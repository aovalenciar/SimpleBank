//
//  InvestmentsView.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/05/26.
//

import SwiftUI

struct InvestmentsView: View {

    @StateObject private var viewModel: InvestmentsViewModel

    init(viewModel: InvestmentsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Inversiones")
        }
        .task {
            await viewModel.load()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Cargando inversiones...")

        case .empty:
            ContentUnavailableView(
                "Sin inversiones",
                systemImage: "tray",
                description: Text("Agrega tu primera inversión para comenzar.")
            )

        case .success(let rows):
            List(rows) { row in
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
                .padding(.vertical, 8)
            }

        case .error(let message):
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)

                Text(message)
                    .multilineTextAlignment(.center)

                Button("Reintentar") {
                    Task {
                        await viewModel.load()
                    }
                }
            }
            .padding()
        }
    }
}
