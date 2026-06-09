//
//  InvestmentsView.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/05/26.
//

import SwiftUI

struct InvestmentsContentView: View {

    let state: InvestmentsViewState
    let onRetry: () -> Void
    let onSelectInvestment: (UUID) -> Void

    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .idle, .loading:
            ProgressView("Cargando inversiones...")

        case .empty:
            ContentUnavailableView(
                "Sin inversiones",
                systemImage: "tray",
                description: Text("Agrega tu primera inversión para comenzar.")
            )

        case .success(let rows):
            List(rows) { row in
                InvestmentRowView(row: row)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onSelectInvestment(row.id)
                    }
            }

        case .error(let message):
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)

                Text(message)
                    .multilineTextAlignment(.center)

                Button("Reintentar") {
                    onRetry()
                }
            }
            .padding()
        }
    }
}

struct InvestmentsView: View {

    @StateObject private var viewModel: InvestmentsViewModel
    @StateObject private var router: InvestmentsRouter

    init(
        viewModel: InvestmentsViewModel,
        router: InvestmentsRouter
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            InvestmentsContentView(
                state: viewModel.state,
                onRetry: {
                    Task {
                        await viewModel.load()
                    }
                },
                onSelectInvestment: { id in
                    router.navigateToDetail(id: id)
                }
            )
            .navigationTitle("Investments")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: InvestmentsRoute.self) { route in
                switch route {
                case .detail(let id):
                    InvestmentDetailView(investmentID: id)
                }
            }
            .task {
                await viewModel.loadIfNeeded()
            }
        }
    }
}
