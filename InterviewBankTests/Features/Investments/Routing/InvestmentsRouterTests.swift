//
//  InvestmentsRouterTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 08/06/26.
//

import XCTest
@testable import InterviewBank

@MainActor
final class InvestmentsRouterTests: XCTestCase {

    func test_navigateToDetail_appendsDetailRoute() {
        let sut = InvestmentsRouter()
        let id = UUID()

        sut.navigateToDetail(id: id)

        XCTAssertEqual(sut.path, [.detail(id: id)])
    }

    func test_pop_removesLastRoute() {
        let sut = InvestmentsRouter()
        let id = UUID()

        sut.navigateToDetail(id: id)
        sut.pop()

        XCTAssertTrue(sut.path.isEmpty)
    }

    func test_popToRoot_removesAllRoutes() {
        let sut = InvestmentsRouter()

        sut.navigateToDetail(id: UUID())
        sut.navigateToDetail(id: UUID())

        sut.popToRoot()

        XCTAssertTrue(sut.path.isEmpty)
    }
}
