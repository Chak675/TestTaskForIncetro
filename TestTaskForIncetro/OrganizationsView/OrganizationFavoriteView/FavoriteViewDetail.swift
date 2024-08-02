//
//  FavoriteViewDetail.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 02.08.2024.
//

import SwiftUI

struct FavoriteViewDetail: View {
    
    let organization: OrganizationModelDetail

    @ObservedObject var viewModel: OrganizationDetailViewModel
    
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
    FavoriteViewDetail(organization: OrganizationModelDetail(
        id: 1,
        name: "Bar",
        categoryName: "",
        rate: 0.0,
        photos: [URL(fileURLWithPath: "")],
        isFavorite: true
    ),
     viewModel: OrganizationDetailViewModel()
    )
}
