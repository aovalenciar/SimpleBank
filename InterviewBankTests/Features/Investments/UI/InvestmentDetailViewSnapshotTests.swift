//
//  InvestmentDetailViewSnapshotTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 08/06/26.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import InterviewBank

@MainActor
final class InvestmentsViewSnapshotTests: XCTestCase {

    func test_loadingState_lightMode() {
        assertSnapshot(
            of: makeSUT(state: .loading)
                .environment(\.colorScheme, .light),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_emptyState_lightMode() {
        assertSnapshot(
            of: makeSUT(state: .empty)
                .environment(\.colorScheme, .light),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_errorState_lightMode() {
        assertSnapshot(
            of: makeSUT(state: .error("No pudimos cargar tus inversiones."))
                .environment(\.colorScheme, .light),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_successState_lightMode() {
        assertSnapshot(
            of: makeSUT(
                state: .success([
                    InvestmentRowViewModel(
                        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                        title: "Nu",
                        balanceText: "$25,000.00",
                        annualRateText: "13% anual"
                    )
                ])
            )
            .environment(\.colorScheme, .light),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    private func makeSUT(
        state: InvestmentsViewState
    ) -> some View {
        let viewModel = InvestmentsViewModel(
            fetchInvestmentsUseCase: FetchInvestmentsUseCaseStub(
                result: .success([])
            ),
            initialState: state
        )

        let router = InvestmentsRouter()

        return InvestmentsView(
            viewModel: viewModel,
            router: router
        )
    }
}
