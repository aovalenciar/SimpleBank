//
//  InvestmentsViewState.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/05/26.
//

enum InvestmentsViewState: Equatable {
    case loading
    case success([InvestmentRowViewModel])
    case empty
    case error(String)
}
