//
//  OrganizationsViewModel.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 15.07.2024.
//

import Foundation


enum Host: String {
    case develop = "https://api.mycyprus.app/api/internship/organizations/category/1/organizations/"
}

// переделать на enum.
struct Token {
    
    static let value = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTg1LCJleHAiOjE3MjIwMDE3NTR9.Q8zpGEyUyafb34mLYIs7BJ6TrengqfTGUHD6WGKfSCY"
}

@MainActor
class OrganizationViewModel: ObservableObject {
    
    @Published var organizations = [Data]()
    
    func getOrganizations() async throws {
        guard let url = URL(string: Host.develop.rawValue) else { throw fatalError() }
        var request = URLRequest(url: url)
        
        request.addValue("Token \(Token.value)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        organizations = try JSONDecoder().decode(OrganizationsModel.self, from: data).data
        
    }
}
