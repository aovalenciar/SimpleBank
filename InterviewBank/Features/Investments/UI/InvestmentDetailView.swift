//
//  InvestmentDetailView.swift
//  InterviewBank
//
//  Created by Alan Valencia on 08/06/26.
//

import SwiftUI
import Foundation

struct InvestmentDetailView: View {

    let investmentID: UUID

    var body: some View {
        VStack(spacing: 16) {
            Text("Investment Detail")
                .font(.title.bold())

            Text(investmentID.uuidString)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .navigationTitle("Detail")
    }
}
