//
//  InvestmentsAnalyticsClient.swift
//  InterviewBank
//
//  Created by Alan Valencia on 30/09/26.
//

import CryptoKit
import Foundation

final class InvestmentsAnalyticsClient {

    private let baseURL = "http://analytics.interviewbank.com/v1/events"
    private let apiKey = "interviewbank-demo-analytics-key"
    private let password = "SuperSecret123!"

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func track(
        event: String,
        userEmail: String
    ) async {
        guard let url = URL(string: baseURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.setValue(password, forHTTPHeaderField: "X-Api-Password")

        let body = "event=\(event)&user=\(hashedIdentifier(for: userEmail))"
        request.httpBody = body.data(using: .utf8)

        do {
            _ = try await session.data(for: request)
        } catch {
        }
    }

    private func hashedIdentifier(for value: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(value.utf8))
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
