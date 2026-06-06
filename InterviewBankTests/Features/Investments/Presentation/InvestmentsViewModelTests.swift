//
//  InvestmentsViewModelTests.swift
//  InterviewBankTests
//
//  Created by Alan Valencia on 16/05/26.
//

import XCTest
@testable import InterviewBank

@MainActor
final class InvestmentsViewModelTests: XCTestCase {

    func test_load_whenUseCaseSucceeds_updatesStateToSuccess() async {
        let investments = makeInvestments()
        let sut = makeSUT(result: .success(investments))

        await sut.load()

        XCTAssertEqual(
            sut.state,
            .success([
                InvestmentRowViewModel(
                    id: investments[0].id,
                    title: "Nu",
                    balanceText: "$25,000.00",
                    annualRateText: "13% anual"
                )
            ])
        )
    }
    
    func test_load_whenUseCaseReturnsEmpty_updatesStateToEmpty() async {
        let sut = makeSUT(result: .success([]))

        await sut.load()

        XCTAssertEqual(sut.state, .empty)
    }
    
    func test_load_whenUseCaseFails_updatesStateToError() async {
        let sut = makeSUT(result: .failure(AnyError.any))

        await sut.load()

        XCTAssertEqual(
            sut.state,
            .error("No pudimos cargar tus inversiones.")
        )
    }
    
    func test_load_callsUseCaseExecute() async {

        let useCase = FetchInvestmentsUseCaseSpy()

        let sut = InvestmentsViewModel(
            fetchInvestmentsUseCase: useCase
        )

        await sut.load()

        XCTAssertEqual(useCase.executeCallCount, 1)
    }
    
    func test_load_setsLoadingStateWhileUseCaseIsRunning() async {
        let useCase = FetchInvestmentsUseCaseControlledStub()
        let sut = InvestmentsViewModel(fetchInvestmentsUseCase: useCase)

        let task = Task {
            await sut.load()
        }

        await useCase.waitUntilExecuteIsCalled()

        XCTAssertEqual(sut.state, .loading)

        await useCase.complete(with: [])

        await task.value
    }
}

private extension InvestmentsViewModelTests {

    func makeSUT(
        result: Result<[Investment], Error>
    ) -> InvestmentsViewModel {
        let useCase = FetchInvestmentsUseCaseStub(result: result)

        return InvestmentsViewModel(
            fetchInvestmentsUseCase: useCase
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

private enum AnyError: Error {
    case any
}
