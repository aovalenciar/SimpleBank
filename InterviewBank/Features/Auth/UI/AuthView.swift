//
//  AuthView.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import SwiftUI

import SwiftUI

struct AuthView: View {

    @StateObject private var viewModel: AuthViewModel

    init(
        viewModel: AuthViewModel
    ) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("SimpleBank")
                .font(.largeTitle.bold())

            Button("Login") {
                Task {
                    await viewModel.loginTapped()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.state == .loading)

            switch viewModel.state {
            case .idle:
                EmptyView()

            case .loading:
                ProgressView("Iniciando sesión...")

            case .error(let message):
                Text(message)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}
