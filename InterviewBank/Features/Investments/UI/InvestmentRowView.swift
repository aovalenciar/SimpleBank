//
//  InvestmentRowView.swift
//  InterviewBank
//
//  Created by Alan Valencia on 08/06/26.
//

import SwiftUI

struct InvestmentRowView: View {

    let row: InvestmentRowViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(row.title)
                .font(.headline)

            Text(row.balanceText)
                .font(.title3)
                .fontWeight(.semibold)

            Text(row.annualRateText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}
