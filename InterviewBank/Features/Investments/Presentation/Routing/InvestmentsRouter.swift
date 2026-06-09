//
//  InvestmentsRouter.swift
//  InterviewBank
//
//  Created by Alan Valencia on 08/06/26.
//

import Foundation
import Combine

@MainActor
final class InvestmentsRouter: ObservableObject {

    @Published var path: [InvestmentsRoute] = []

    func navigateToDetail(id: UUID) {
        path.append(.detail(id: id))
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}
