//
//  OrganizationDetailViewModel.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 18.07.2024.
//

import Foundation

enum HostOrganization: String {
    case develop = "https://api.mycyprus.app/api/internship/organization/"
    case token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTg1LCJleHAiOjE3MjIwMDE3NTR9.Q8zpGEyUyafb34mLYIs7BJ6TrengqfTGUHD6WGKfSCY"
}


@MainActor
class OrganizationDetailViewModel: ObservableObject {
    
    @Published var organizationsDetail: OrganizationModelDetail = .default
    @Published var rating = 0.0
    
    init() {
        $organizationsDetail
            .compactMap { $0.rate }
            .assign(to: &$rating)
    }
    
    
    func getOrganizationsDetail(id: Int) async throws {
        guard let url = URL(string: (HostOrganization.develop.rawValue) + "\(id)/") else { throw fatalError() }
        print("URL for server: \(url)")
        
        var request = URLRequest(url: url)
        
        request.addValue("Token \(HostOrganization.token.rawValue)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        organizationsDetail = try JSONDecoder().decode(OrganizationModelDetail.self, from: data)
    }
}
