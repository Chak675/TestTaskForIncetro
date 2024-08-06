//
//  OrganizationsViewModel.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 15.07.2024.
//

import Foundation

@MainActor
class OrganizationViewModel: ObservableObject {
    
    @Published private var organizations = [OrganizationsData]()
    @Published var favoriteCount = 0
    @Published var favoriteList = [OrganizationsData]()
    @Published var showFavorites = false
    
    let favoriteService = FavoriteService()
    
    init() {
        $organizations.compactMap {
            $0.filter({ $0.isFavorite }).count
        }
        .assign(to: &$favoriteCount)
        
        $showFavorites.map { [unowned self] in
            $0 ? organizations.filter({ $0.isFavorite }) : organizations
        }
        .assign(to: &$favoriteList)
        
        $organizations.map {
            $0
        }
        .assign(to: &$favoriteList)
    }
    
    func getOrganizations() async throws {
        guard let url = URL(string: HostOrganization.developOrganizationPageOne.rawValue) else { throw CustomError.network }
        var request = URLRequest(url: url)
        
        request.addValue("Token \(HostOrganization.token.rawValue)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        organizations = try JSONDecoder().decode(OrganizationsModel.self, from: data).data
    }
    
    func addToFavorite(id: Int) {
        Task {
            let id = try await favoriteService.addOrganizationsFavorite(id: id)
            guard let index = organizations.firstIndex(where: { $0.id == id }) else { return }
            
            let organisation = organizations[index]
            organizations[index] = OrganizationsData(
                id: organisation.id,
                name: organisation.name,
                photo: organisation.photo,
                rate: organisation.rate,
                averageCheck: organisation.averageCheck,
                cuisines: organisation.cuisines,
                isFavorite: true
            )
        }
    }
 
    func removeFromFavorite(id: Int) {
        Task {
            let isRemoved = try await favoriteService.deleteOrganizationsFavorite(id: id)
            guard isRemoved, let index = organizations.firstIndex(where: { $0.id == id }) else { return }
            
            let organisation = organizations[index]
            organizations[index] = OrganizationsData(
                id: organisation.id,
                name: organisation.name,
                photo: organisation.photo,
                rate: organisation.rate,
                averageCheck: organisation.averageCheck,
                cuisines: organisation.cuisines,
                isFavorite: false
            )
        }
    }
}
