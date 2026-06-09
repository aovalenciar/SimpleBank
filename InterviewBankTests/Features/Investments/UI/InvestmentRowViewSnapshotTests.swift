//
//  InvestmentRowViewSnapshotTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import InterviewBank

@MainActor
final class InvestmentRowViewSnapshotTests: XCTestCase {

    func test_row_lightMode() {
        assertSnapshot(
            of: makeSUT(colorScheme: .light),
            as: .image(layout: .fixed(width: 390, height: 100))
        )
    }

    func test_row_darkMode() {
        assertSnapshot(
            of: makeSUT(colorScheme: .dark),
            as: .image(layout: .fixed(width: 390, height: 100))
        )
    }
}

private extension InvestmentRowViewSnapshotTests {

    func makeSUT(colorScheme: ColorScheme) -> some View {
        InvestmentRowView(
            row: InvestmentRowViewModel(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                title: "Nu",
                balanceText: "$25,000.00",
                annualRateText: "13% anual"
            )
        )
        .padding(.horizontal, 16)
        .frame(width: 390, height: 100, alignment: .leading)
        .background(Color(.systemBackground))
        .environment(\.colorScheme, colorScheme)
    }
}
