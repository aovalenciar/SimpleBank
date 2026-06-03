//
//  FetchInvestmentsUseCaseControlledSpy.swift
//  InterviewBank
//
//  Created by Alan Valencia on 19/05/26.
//

@testable import InterviewBank

final class FetchInvestmentsUseCaseControlledSpy: FetchInvestmentsUseCaseProtocol {

    private(set) var executeCallCount = 0
    private var continuation: CheckedContinuation<[Investment], Error>?
    private var pendingResult: Result<[Investment], Error>?

    // MARK: - FetchInvestmentsUseCaseProtocol
    
    func execute() async throws -> [Investment] {
        executeCallCount += 1

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

    func complete(with investments: [Investment]) {
        complete(with: .success(investments))
    }

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
