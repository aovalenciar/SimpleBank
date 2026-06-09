//
//  InvestmentsView.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/05/26.
//

import SwiftUI

struct InvestmentsView: View {

    @StateObject private var viewModel: InvestmentsViewModel
    @StateObject private var router: InvestmentsRouter

    init(viewModel: InvestmentsViewModel,
         router: InvestmentsRouter) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: InvestmentsRoute.self) { route in
                    switch route {
                    case .detail(let id):
                        InvestmentDetailView(investmentID: id)
                    }
                }
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
                InvestmentRowView(row: row)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        router.navigateToDetail(id: row.id)
                    }
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
