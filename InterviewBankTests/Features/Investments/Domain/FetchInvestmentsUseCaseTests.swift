//
//  FetchInvestmentsUseCaseTests.swift
//  InterviewBankTests
//
//  Created by Alan Valencia on 14/05/26.
//

import XCTest
@testable import InterviewBank

final class FetchInvestmentsUseCaseTests: XCTestCase {

    func test_execute_whenRepositorySucceeds_returnsInvestments() async throws {
        let expectedInvestments = makeInvestments()
        let sut = makeSUT(result: .success(expectedInvestments))

        let result = try await sut.execute()

        XCTAssertEqual(result, expectedInvestments)
    }
    
    func test_execute_whenRepositoryFails_throwsError() async {
        let sut = makeSUT(result: .failure(AnyError.any))

        do {
            _ = try await sut.execute()
            XCTFail("Expected execute() to throw")
        } catch {
            XCTAssertEqual(error as? AnyError, .any)
        }
    }
}

private extension FetchInvestmentsUseCaseTests {

    func makeSUT(
        result: Result<[Investment], Error> = .success([])
    ) -> FetchInvestmentsUseCase {
        let repository = InvestmentsRepositoryStub(result: result)

        return FetchInvestmentsUseCase(
            repository: repository
        )
    }

    func makeInvestments() -> [Investment] {
        [
            Investment(
                id: UUID(),
                institutionName: "Nu",
                balance: 25_000,
                annualRate: 0.13
            )
        ]
    }
}

private final class InvestmentsRepositoryStub: InvestmentsRepositoryProtocol {

    private let result: Result<[Investment], Error>

    init(result: Result<[Investment], Error>) {
        self.result = result
    }

    func fetchInvestments() async throws -> [Investment] {
        try result.get()
    }
}

private enum AnyError: Error, Equatable {
    case any
}
