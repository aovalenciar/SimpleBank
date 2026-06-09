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
final class InvestmentDetailViewSnapshotTests: XCTestCase {

    func test_detailView_lightMode() {
        let sut = makeSUT()
            .environment(\.colorScheme, .light)

        assertSnapshot(
            of: sut,
            as: .image(layout: .device(config: .iPhone13))
        )
    }

    func test_detailView_darkMode() {
        let sut = makeSUT()
            .environment(\.colorScheme, .dark)

        assertSnapshot(
            of: sut,
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
