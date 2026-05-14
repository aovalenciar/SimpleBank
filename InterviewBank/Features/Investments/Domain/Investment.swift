//
//  Investment.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/05/26.
//

import Foundation

struct Investment: Identifiable, Equatable {
    let id: UUID
    let institutionName: String
    let balance: Decimal
    let annualRate: Decimal
}
