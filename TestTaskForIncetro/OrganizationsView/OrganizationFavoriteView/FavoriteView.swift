//
//  FavoriteView.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 25.07.2024.
//

import SwiftUI

struct FavoriteView: View {
    
    let organization: OrganizationsData

    @ObservedObject var viewModel: OrganizationViewModel
    
    var body: some View {
        HStack {
            Button {
                organization.isFavorite
                ? viewModel.removeFromFavorite(id: organization.id)
                : viewModel.addToFavorite(id: organization.id)
                
            } label: {
                Image(systemName: organization.isFavorite ? "suit.heart.fill" : "suit.heart")
            }
        }
        .padding(.all)
        .foregroundStyle(.cyan)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    FavoriteView(
        organization: OrganizationsData(
            id: 1,
            name: "Bar",
            photo: URL(fileURLWithPath: ""),
            rate: 0.0,
            averageCheck: [],
            cuisines: [],
            isFavorite: true
        ),
        viewModel: OrganizationViewModel()
    )
}
