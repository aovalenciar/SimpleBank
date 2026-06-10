//
//  AuthView.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

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
                viewModel.loginTapped()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
