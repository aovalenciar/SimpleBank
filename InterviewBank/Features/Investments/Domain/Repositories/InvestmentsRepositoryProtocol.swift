//
//  InvestmentsRepositoryProtocol.swift
//  InterviewBank
//
//  Created by Alan Valencia on 14/05/26.
//

import Foundation

protocol InvestmentsRepositoryProtocol {
    func fetchInvestments() async throws -> [Investment]
}
