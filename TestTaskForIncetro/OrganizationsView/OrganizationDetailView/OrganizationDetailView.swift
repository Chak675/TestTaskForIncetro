//
//  OrganizationDetailView.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 18.07.2024.
//

import SwiftUI

struct OrganizationDetailView: View {
    
    let organizationID: Int
    let viewModel = OrganizationDetailViewModel().organizationsDetail
//    let organizationID = viewModel.id
    
    @StateObject private var viewDetail = OrganizationDetailViewModel()
    @StateObject private var favoriteService = FavoriteService()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewDetail.organizationsDetail.photos, id: \.self) { photo in
                                AsyncImage(url: photo) { image in
                                    image.resizable()
                                        .frame(width: 400, height: 250)
                                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 25.0, bottomLeadingRadius: 0.0, bottomTrailingRadius: 0.0, topTrailingRadius: 25.0))
                                } placeholder: { ProgressView("Loading...") }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(.white.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                }
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
                VStack {
                    HStack {
                        Text(viewDetail.organizationsDetail.name)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        FavoriteViewDetail(organization: viewDetail.organizationsDetail, viewModel: viewDetail)
                    }
                    
                    HStack {
                        RaitingView(raiting: viewDetail.rating)
                        Text(String(format: "%.1f", viewDetail.rating))
                            .foregroundStyle(.cyan)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(width: 380, height: 82, alignment: .leading)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                VStack {
                    Text("Описание: Рестора́н (от лат. restauro «восстановить, крепить») — предприятие общественного питания с широким ассортиментом блюд сложного приготовления, включая заказные и фирменные. Блюда, как правило, подаются и съедаются на месте в ресторане, но многие рестораны также предлагают блюда навынос и доставку еды, а некоторые предлагают только вынос и доставку. Рестораны сильно различаются по внешнему виду и предложениям, включая большое разнообразие кухонь и видов обслуживания, от недорогих «ресторанов» быстрого питания до семейных ресторанов со средней ценой и дорогих заведений класса люкс.В западных странах в большинстве ресторанов среднего и высокого класса подают алкогольные напитки, такие как пиво и вино. В некоторых ресторанах подают все основные блюда, такие как завтрак, обед и ужин (например, крупные сети быстрого питания, закусочные, гостиничные рестораны и рестораны в аэропортах). В других ресторанах еда может быть подана только один раз (например, в блинных ресторанах может быть только завтрак), или они могут подавать еду два раза за день (например, обед и ужин). Владелец ресторанного бизнеса называется ресторатором; оба слова произошли от французского глагола restaurer «восстанавливать, укреплять; кормить». Restaurant в американском английском — любое предприятие общепита вообще, а не только ресторан в привычном смысле.")
                        .padding()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            .background(.gray.opacity(0.1))
            .navigationTitle("Restaurants")
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(favoriteService)
        .onAppear {
            Task {
                try await viewDetail.getOrganizationsDetail(id: organizationID)
            }
        }
    }
}

//#Preview {
////    OrganizationDetailView(organizationID: 2365)
//}
