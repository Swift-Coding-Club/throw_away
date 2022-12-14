//
//  StatisticsView.swift
//  ThrowAway
//
//  Created by 지준용 on 2022/10/30.
//

import SwiftUI

struct StatisticsView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.cleaningDay, ascending: true)],
        animation: .default
    )
    private var products: FetchedResults<Product>

    private let setWidth = UIScreen.main.bounds.width
    private let screenWidth = UIScreen.main.bounds.width
        
    var body: some View {
        VStack {
            VStack {
                DateScrollView()
                    .environmentObject(dateHolder)
                
                Text("이번 달의 달성도는 81%입니다.")
                    .padding(.vertical, 20)
                    .font(.system(size: 20))
                
                DayOfWeekView()
                CalendarView()
            }
            .padding(.horizontal, 16)
            
            // TODO: 조건에 맞는 물건을 coredata에서 불러오기
            let notYetCleaningProducts = products.filter{ $0.isCleanedUp == false }
            let lateCleanedUpProducts = products.filter{ $0.isCleanedUp == false }
            
            makeSectionView(label: "버리지 못한 물건", products: notYetCleaningProducts)
            makeSectionView(label: "늦게 버린 물건", products: lateCleanedUpProducts)
        }
    }
    
    private func makeSectionView(label: String, products: [Product]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(label)(\(products.count))")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                Spacer()
            }
            makeHorizontalScrollView(from: products)
        }
        .padding(.leading, 16)
    }
    
    private func makeHorizontalScrollView(from products: [Product]) -> some View {
        let items: [(id: ObjectIdentifier, image: Image)] = products.map { product in
            var image = Image(systemName: "photo")
            if (product.photo != nil), let photo = Image(data: product.photo!) {
                image = photo
            }
            return (product.id, image: image)
        }
        
        return ScrollView(.horizontal) {
            HStack {
                ForEach(items, id: \.self.id) { item in
                    item.image
                        .resizable()
                        .frame(width: screenWidth / 6, height: screenWidth / 6, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                }
            }
        }
    }
}

private extension Image {
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self = .init(uiImage: image)
    }
}
