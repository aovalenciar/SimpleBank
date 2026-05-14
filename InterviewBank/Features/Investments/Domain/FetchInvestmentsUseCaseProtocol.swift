//
//  FetchInvestmentsUseCaseProtocol.swift
//  InterviewBank
//
//  Created by Alan Valencia on 13/05/26.
//

protocol FetchInvestmentsUseCaseProtocol {
    func execute() async throws -> [Investment]
}
