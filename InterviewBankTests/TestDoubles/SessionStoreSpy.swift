//
//  SessionStoreSpy.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/06/26.
//

@testable import InterviewBank

final class SessionStoreSpy: SessionStoring {
    
    var tokens: AuthTokens?
    var saveTokensCallCount = 0
    var clearSessionCallCount = 0
    
    func saveTokens(_ tokens: AuthTokens) throws {
        saveTokensCallCount += 1
        self.tokens = tokens
    }
    
    func readTokens() throws -> AuthTokens? {
        tokens
    }
    
    func clearSession() throws {
        clearSessionCallCount += 1
        tokens = nil
    }
}
