//
//  AuthRepositoryProtocol.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/06/26.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(
        email: String,
        password: String
    ) async throws -> AuthTokens
}
