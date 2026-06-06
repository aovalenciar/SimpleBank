//
//  FetchInvestmentsUseCaseControlledStub.swift
//  InterviewBank
//
//  Created by Alan Valencia on 19/05/26.
//

@testable import InterviewBank

/// A controlled stub for `FetchInvestmentsUseCaseProtocol` that suspends `execute()` until
/// the test explicitly unblocks it via `complete(with:)`.
///
/// This lets tests assert on intermediate states (e.g. `.loading`) that only exist
/// while `execute()` is in flight — something a regular stub cannot do, because a regular
/// stub returns immediately and the loading state never has a chance to be observed.
///
/// ---
///
/// **The two-continuation mechanism**
///
/// The stub uses two `CheckedContinuation` values, each solving a different problem:
///
/// 1. `callerContinuation` — bridges the gap between the test and `execute()`.
///    The test calls `waitUntilExecuteIsCalled()`, which suspends and stores this
///    continuation. When `execute()` eventually runs, it resumes the continuation,
///    waking the test up at exactly the right moment.
///
/// 2. `resultContinuation` — keeps `execute()` itself suspended after it has signalled
///    the test. `execute()` stores this continuation and then waits. When the test is
///    done asserting and calls `complete(with:)`, the stub resumes the continuation
///    with the desired result, unblocking `execute()` so it can return normally.
///
/// ---
///
/// **Race condition: what if `execute()` runs before `waitUntilExecuteIsCalled()`?**
///
/// The `wasExecuteCalled` flag handles this. When `waitUntilExecuteIsCalled()` is called
/// after `execute()` has already run, it reads `true` and returns immediately — no
/// suspension needed, no event missed. Without this flag, the test would suspend forever
/// because there would be nobody left to resume `callerContinuation`.
///
/// ---
///
/// **Timeline of a typical test**
///
/// ```
/// TEST TASK                               LOAD TASK
/// ─────────────────────────────────────   ──────────────────────────────
/// Task { await sut.load() }           →   load() starts
///                                         calls execute()
///                                         sets wasExecuteCalled = true
///                                         resumes callerContinuation ──→ wakes test
///                                         suspends on resultContinuation
///
/// waitUntilExecuteIsCalled() returns  ←
/// XCTAssertEqual(sut.state, .loading)     (still suspended here)
/// complete(with: [])                  →   resultContinuation resumes
///                                         execute() returns []
///                                         load() finishes
/// await task.value                    ←
/// ```
///
/// ---
///
/// **Typical test usage**
///
/// ```swift
/// let useCase = FetchInvestmentsUseCaseControlledStub()
/// let sut = InvestmentsViewModel(fetchInvestmentsUseCase: useCase)
///
/// let task = Task { await sut.load() }
///
/// await useCase.waitUntilExecuteIsCalled()
/// // execute() is now suspended → safe to assert on any intermediate state
/// XCTAssertEqual(sut.state, .loading)
///
/// await useCase.complete(with: [])  // unblock execute()
/// await task.value                  // wait for load() to finish
/// ```
actor FetchInvestmentsUseCaseControlledStub: FetchInvestmentsUseCaseProtocol {

    // True once execute() has been called at least once.
    // Guards against the race where execute() runs before waitUntilExecuteIsCalled().
    private var wasExecuteCalled = false

    // Resumed by execute() to wake up waitUntilExecuteIsCalled().
    private var callerContinuation: CheckedContinuation<Void, Never>?

    // Kept alive inside execute() to hold it suspended until complete(with:) is called.
    private var resultContinuation: CheckedContinuation<[Investment], Error>?

    // MARK: - FetchInvestmentsUseCaseProtocol

    func execute() async throws -> [Investment] {
        // Signal the test that we have been reached.
        wasExecuteCalled = true
        callerContinuation?.resume()
        callerContinuation = nil

        // Suspend here and hand control back to the test.
        // The test asserts on intermediate state, then calls complete(with:) to resume us.
        return try await withCheckedThrowingContinuation { continuation in
            resultContinuation = continuation
        }
    }

    // MARK: - Utils

    /// Suspends until `execute()` has been invoked.
    /// Returns immediately if `execute()` already ran before this call.
    func waitUntilExecuteIsCalled() async {
        if wasExecuteCalled { return }
        await withCheckedContinuation { continuation in
            callerContinuation = continuation
        }
    }

    /// Unblocks `execute()` and makes it return a successful list of investments.
    func complete(with investments: [Investment]) {
        resultContinuation?.resume(returning: investments)
        resultContinuation = nil
    }

    /// Unblocks `execute()` and makes it throw an error.
    func complete(with error: Error) {
        resultContinuation?.resume(throwing: error)
        resultContinuation = nil
    }
}
