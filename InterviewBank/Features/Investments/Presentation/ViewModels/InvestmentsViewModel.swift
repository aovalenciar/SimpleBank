//
//  InvestmentsViewModel.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/05/26.
//

import Foundation
import Combine

@MainActor
final class InvestmentsViewModel: ObservableObject {

    @Published private(set) var state: InvestmentsViewState = .loading

    private let fetchInvestmentsUseCase: FetchInvestmentsUseCaseProtocol

    init(fetchInvestmentsUseCase: FetchInvestmentsUseCaseProtocol) {
        self.fetchInvestmentsUseCase = fetchInvestmentsUseCase
    }

    func load() async {
        state = .loading

        do {
            let investments = try await fetchInvestmentsUseCase.execute()
            let rows = investments.map(makeRowViewModel)

            state = rows.isEmpty ? .empty : .success(rows)
        } catch {
            state = .error("No pudimos cargar tus inversiones.")
        }
    }

    private func makeRowViewModel(
        from investment: Investment
    ) -> InvestmentRowViewModel {
        InvestmentRowViewModel(
            id: investment.id,
            title: investment.institutionName,
            balanceText: formatCurrency(investment.balance),
            annualRateText: formatRate(investment.annualRate)
        )
    }

    private func formatCurrency(_ value: Decimal) -> String {
        value.formatted(
            .currency(code: "MXN")
            .locale(Locale(identifier: "es_MX"))
        )
    }

    private func formatRate(_ value: Decimal) -> String {
        let percentage = value * 100
        return "\(percentage)% anual"
    }
}
