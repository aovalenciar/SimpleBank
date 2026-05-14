//
//  FetchInvestmentsUseCase.swift
//  InterviewBank
//
//  Created by Alan Valencia on 13/05/26.
//

import Foundation

final class FetchInvestmentsUseCase: FetchInvestmentsUseCaseProtocol {

    func execute() async throws -> [Investment] {
        try await Task.sleep(for: .seconds(3))
        
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
