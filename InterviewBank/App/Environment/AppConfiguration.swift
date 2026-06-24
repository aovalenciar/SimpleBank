//
//  AppConfiguration.swift
//  InterviewBank
//
//  Created by Alan Valencia on 13/06/26.
//

import Foundation

enum AppConfiguration {

    static var current: EnvironmentConfiguration {

        guard
            let environmentRawValue = Bundle.main.object(
                forInfoDictionaryKey: "APP_ENVIRONMENT"
            ) as? String,
            let environment = AppEnvironment(
                rawValue: environmentRawValue
            )
        else {
            fatalError(
                "APP_ENVIRONMENT not configured"
            )
        }

        guard
            let apiBaseURLString = Bundle.main.object(
                forInfoDictionaryKey: "API_BASE_URL"
            ) as? String,
            let apiBaseURL = URL(
                string: apiBaseURLString
            )
        else {
            fatalError(
                "API_BASE_URL not configured"
            )
        }

        guard
            let supabaseURLString = Bundle.main.object(
                forInfoDictionaryKey: "SUPABASE_URL"
            ) as? String,
            let supabaseURL = URL(
                string: supabaseURLString
            )
        else {
            fatalError(
                "SUPABASE_URL not configured"
            )
        }

        guard
            let supabaseAnonKey = Bundle.main.object(
                forInfoDictionaryKey: "SUPABASE_ANON_KEY"
            ) as? String
        else {
            fatalError(
                "SUPABASE_ANON_KEY not configured"
            )
        }

        return EnvironmentConfiguration(
            environment: environment,
            apiBaseURL: apiBaseURL,
            supabaseURL: supabaseURL,
            supabaseAnonKey: supabaseAnonKey
        )
    }
}
