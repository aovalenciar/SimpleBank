//
//  InvestmentsBuilder.swift
//  InterviewBank
//
//  Created by Alan Valencia on 08/06/26.
//

import SwiftUI

enum InvestmentsBuilder {

    @MainActor
    static func build() -> some View {

        let repository = InvestmentsRepository()

        let useCase = FetchInvestmentsUseCase(
            repository: repository
        )

        let viewModel = InvestmentsViewModel(
            fetchInvestmentsUseCase: useCase
        )

        let router = InvestmentsRouter()

        return InvestmentsView(
            viewModel: viewModel,
            router: router
        )
    }
}
