//
//  InvestmentsRepository.swift
//  InterviewBank
//
//  Created by Alan Valencia on 14/05/26.
//

import Foundation

final class InvestmentsRepository: InvestmentsRepositoryProtocol {

    func fetchInvestments() async throws -> [Investment] {
        try await Task.sleep(for: .seconds(1))

        return [
            Investment(
                id: UUID(),
                institutionName: "Plata",
                balance: 496_702,
                annualRate: 0.12
            ),
            Investment(
                id: UUID(),
                institutionName: "Nu",
                balance: 25_000,
                annualRate: 0.13
            ),
            Investment(
                id: UUID(),
                institutionName: "Mercado Pago",
                balance: 25_000,
                annualRate: 0.13
            )
        ]
    }
}
