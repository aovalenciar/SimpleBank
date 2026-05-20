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

    func execute() async throws -> [Investment] {
        executeCallCount += 1

        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        }
    }

    func complete(with investments: [Investment]) {
        continuation?.resume(returning: investments)
        continuation = nil
    }

    func complete(with error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
}
