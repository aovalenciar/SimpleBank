//
//  InterviewBankApp.swift
//  InterviewBank
//
//  Created by Alan Valencia on 11/05/26.
//

import SwiftUI

@main
struct InterviewBankApp: App {
    var body: some Scene {
        WindowGroup {
            InvestmentsView(
                viewModel: InvestmentsViewModel(
                    fetchInvestmentsUseCase: FetchInvestmentsUseCase()
                )
            )
        }
    }
}
