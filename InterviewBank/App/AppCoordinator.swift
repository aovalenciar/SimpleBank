//
//  AppCoordinator.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import SwiftUI

struct AppCoordinator: View {
    
    @StateObject private var sessionManager = SessionManager()
    
    var body: some View {
        switch sessionManager.state {
            
        case .loggedOut:
            AuthBuilder.build(
                sessionManager: sessionManager
            )
            
        case .loggedIn:
            InvestmentsBuilder.build(
                onLogout: {
                    sessionManager.logout()
                }
            )
        }
    }
}
