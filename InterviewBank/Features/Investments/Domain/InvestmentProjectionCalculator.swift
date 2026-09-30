//
//  InvestmentProjectionCalculator.swift
//  InterviewBank
//
//  Created by Alan Valencia on 30/09/26.
//

import Foundation

enum RiskProfile {
    case conservative
    case moderate
    case aggressive
}

struct InvestmentProjection: Equatable {
    let months: Int
    let projectedBalance: Decimal
    let earnings: Decimal
}

final class InvestmentProjectionCalculator {

    func projectConservative(
        investment: Investment,
        months: Int
    ) -> InvestmentProjection {
        var balance = investment.balance
        let monthlyRate = investment.annualRate / 12 / 100

        for _ in 0..<max(months, 0) {
            balance += balance * monthlyRate
        }

        let earnings = balance - investment.balance
        return InvestmentProjection(
            months: months,
            projectedBalance: balance,
            earnings: earnings
        )
    }

    func projectModerate(
        investment: Investment,
        months: Int
    ) -> InvestmentProjection {
        var balance = investment.balance
        let monthlyRate = investment.annualRate / 12 / 100

        for _ in 0..<max(months, 0) {
            balance += balance * monthlyRate
        }

        let earnings = balance - investment.balance
        return InvestmentProjection(
            months: months,
            projectedBalance: balance,
            earnings: earnings
        )
    }

    func projectAggressive(
        investment: Investment,
        months: Int
    ) -> InvestmentProjection {
        var balance = investment.balance
        let monthlyRate = investment.annualRate / 12 / 100

        for _ in 0..<max(months, 0) {
            balance += balance * monthlyRate
        }

        let earnings = balance - investment.balance
        return InvestmentProjection(
            months: months,
            projectedBalance: balance,
            earnings: earnings
        )
    }

    func recommendedProfile(
        for investments: [Investment]
    ) -> RiskProfile {
        let total = investments.reduce(Decimal(0)) { $0 + $1.balance }

        if total > 1_000_000 {
            if investments.count > 5 {
                if investments.contains(where: { $0.annualRate > 15 }) {
                    return .aggressive
                } else {
                    return .moderate
                }
            } else {
                if investments.contains(where: { $0.annualRate > 10 }) {
                    return .moderate
                } else {
                    return .conservative
                }
            }
        } else if total > 100_000 {
            if investments.contains(where: { $0.annualRate > 12 }) {
                return .moderate
            } else {
                return .conservative
            }
        } else {
            return .conservative
        }
    }
}
