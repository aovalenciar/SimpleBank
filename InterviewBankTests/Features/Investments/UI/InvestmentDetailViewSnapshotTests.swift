//
//  InvestmentDetailViewSnapshotTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import InterviewBank

@MainActor
final class InvestmentDetailViewSnapshotTests: XCTestCase {

    func test_detailView_lightMode() {
        assertSnapshot(
            of: makeSUT()
                .environment(\.colorScheme, .light),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_detailView_darkMode() {
        assertSnapshot(
            of: makeSUT()
                .environment(\.colorScheme, .dark),
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    private func makeSUT() -> some View {
        InvestmentDetailView(
            investmentID: UUID(
                uuidString: "00000000-0000-0000-0000-000000000001"
            )!
        )
    }
}
