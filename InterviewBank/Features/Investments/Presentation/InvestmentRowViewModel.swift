//
//  InvestmentRowViewModel.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/05/26.
//

import Foundation

struct InvestmentRowViewModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let balanceText: String
    let annualRateText: String
}
