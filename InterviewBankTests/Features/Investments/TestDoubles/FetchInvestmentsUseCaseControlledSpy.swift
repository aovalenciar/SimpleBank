//
//  FetchInvestmentsUseCaseControlledSpy.swift
//  InterviewBank
//
//  Created by Alan Valencia on 19/05/26.
//

@testable import InterviewBank

/// A controlled spy for `FetchInvestmentsUseCaseProtocol` that suspends execution until
/// the test explicitly completes it, allowing assertions on intermediate states (e.g. loading).
///
/// **Typical test usage:**
/// ```swift
/// let useCase = FetchInvestmentsUseCaseControlledSpy()
/// let sut = InvestmentsViewModel(fetchInvestmentsUseCase: useCase)
///
/// let task = Task { await sut.load() }
///
/// await useCase.waitUntilExecuteIsCalled()
/// // execute() has run and is now suspended → assert on the intermediate state
/// XCTAssertEqual(sut.state, .loading)
///
/// useCase.complete(with: [])  // unblock execute()
/// await task.value            // wait for load() to finish
/// ```
actor FetchInvestmentsUseCaseControlledSpy: FetchInvestmentsUseCaseProtocol {

    private(set) var executeCallCount = 0
    private var continuation: CheckedContinuation<[Investment], Error>?
    private var pendingResult: Result<[Investment], Error>?

    // AsyncStream instead of a callback to avoid a race condition: yield() buffers the event,
    // so waitUntilExecuteIsCalled() receives it even if execute() already ran before
    // the for-await loop starts consuming.
    private let executeCalled: AsyncStream<Void>
    private let executeCalledContinuation: AsyncStream<Void>.Continuation

    init() {
        (executeCalled, executeCalledContinuation) = AsyncStream.makeStream()
    }

    // MARK: - FetchInvestmentsUseCaseProtocol

    func execute() async throws -> [Investment] {
        executeCallCount += 1
        executeCalledContinuation.yield()

        return try await withCheckedThrowingContinuation { continuation in
            if let pendingResult {
                self.pendingResult = nil
                continuation.resume(with: pendingResult)
            } else {
                self.continuation = continuation
            }
        }
    }

    // MARK: - Utils

    /// Waits until `execute()` has been invoked at least once.
    func waitUntilExecuteIsCalled() async {
        for await _ in executeCalled { return }
    }

    /// Unblocks `execute()` with a successful list of investments.
    func complete(with investments: [Investment]) {
        complete(with: .success(investments))
    }

    /// Unblocks `execute()` with an error.
    func complete(with error: Error) {
        complete(with: .failure(error))
    }

    private func complete(with result: Result<[Investment], Error>) {
        if let continuation {
            self.continuation = nil
            continuation.resume(with: result)
        } else {
            pendingResult = result
        }
    }
}
