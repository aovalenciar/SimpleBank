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
            of: makeSUT(state: .loading, colorScheme: .light),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_loadingState_darkMode() {
        assertSnapshot(
            of: makeSUT(state: .loading, colorScheme: .dark),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_emptyState_lightMode() {
        assertSnapshot(
            of: makeSUT(state: .empty, colorScheme: .light),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_emptyState_darkMode() {
        assertSnapshot(
            of: makeSUT(state: .empty, colorScheme: .dark),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_errorState_lightMode() {
        assertSnapshot(
            of: makeSUT(
                state: .error("No pudimos cargar tus inversiones."),
                colorScheme: .light
            ),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_errorState_darkMode() {
        assertSnapshot(
            of: makeSUT(
                state: .error("No pudimos cargar tus inversiones."),
                colorScheme: .dark
            ),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_successState_lightMode() {
        assertSnapshot(
            of: makeSUT(
                state: .success(makeRows()),
                colorScheme: .light
            ),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_successState_darkMode() {
        assertSnapshot(
            of: makeSUT(
                state: .success(makeRows()),
                colorScheme: .dark
            ),
            as: .image(layout: .device(config: .iPhone13))
        )
    }
}

private extension InvestmentsViewSnapshotTests {

    func makeSUT(
        state: InvestmentsViewState,
        colorScheme: ColorScheme
    ) -> some View {
        InvestmentsContentView(
            state: state,
            onRetry: {},
            onSelectInvestment: { _ in }
        )
        .environment(\.colorScheme, colorScheme)
    }

    func makeRows() -> [InvestmentRowViewModel] {
        [
            InvestmentRowViewModel(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                title: "Nu",
                balanceText: "$25,000.00",
                annualRateText: "13% anual"
            ),
            InvestmentRowViewModel(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
                title: "Mercado Pago",
                balanceText: "$15,500.00",
                annualRateText: "10% anual"
            )
        ]
    }
}
