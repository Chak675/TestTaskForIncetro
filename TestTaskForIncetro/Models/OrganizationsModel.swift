//
//  OrganizationsModel.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 15.07.2024.
//

import Foundation

struct OrganizationsModel: Codable {
    
    let data: [Data]
}

struct Data: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let photo: String
    let rate: Double?
    let averageCheck: [String] // Int, but not data in server
    let cuisines:  [String]
    let isFavorite: Bool
}
