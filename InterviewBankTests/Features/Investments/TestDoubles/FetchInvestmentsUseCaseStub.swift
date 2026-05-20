//
//  FetchInvestmentsUseCaseStub.swift
//  InterviewBank
//
//  Created by Alan Valencia on 19/05/26.
//

@testable import InterviewBank

final class FetchInvestmentsUseCaseStub: FetchInvestmentsUseCaseProtocol {

    private let result: Result<[Investment], Error>

    init(result: Result<[Investment], Error>) {
        self.result = result
    }

    func execute() async throws -> [Investment] {
        try result.get()
    }
}
