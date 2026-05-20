//
//  FetchInvestmentsUseCaseSpy.swift
//  InterviewBank
//
//  Created by Alan Valencia on 19/05/26.
//

@testable import InterviewBank

final class FetchInvestmentsUseCaseSpy: FetchInvestmentsUseCaseProtocol {

    private(set) var executeCallCount = 0

    func execute() async throws -> [Investment] {
        executeCallCount += 1
        return []
    }
}
