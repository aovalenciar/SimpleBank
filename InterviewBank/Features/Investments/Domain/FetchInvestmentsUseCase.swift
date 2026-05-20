//
//  FetchInvestmentsUseCase.swift
//  InterviewBank
//
//  Created by Alan Valencia on 13/05/26.
//

import Foundation

final class FetchInvestmentsUseCase: FetchInvestmentsUseCaseProtocol {

    private let repository: InvestmentsRepositoryProtocol

    init(repository: InvestmentsRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Investment] {
        try await repository.fetchInvestments()
    }
}
