//
//  StatisticsView.swift
//  ThrowAway
//
//  Created by 지준용 on 2022/10/30.
//

import SwiftUI

struct StatisticsView: View {
    var notThrowArray = ["Test01", "Test02", "Test03", "Test04"]
    var lateThrowArray = ["Test01", "Test02", "Test03"]
    let setWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Text("이번 달의 달성도는 81%입니다.")
                .padding(.top, 20)
                .font(.system(size: 20))
            
            // TODO: - Rectangle = 달력 위치
            Rectangle()
                .size(width: setWidth, height: setWidth)
            
            countingProducts(text: "버리지 못한 물건", products: notThrowArray)
            
            productScroll(productList: notThrowArray)
            
            countingProducts(text: "늦게 버린 물건", products: lateThrowArray)
            
            productScroll(productList: lateThrowArray)
//            Spacer()
        }
    }
    
    func countingProducts(text: String , products: [String]) -> some View {
        HStack {
            Text("\(text)(\(products.count))")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.leading, 16)
//                .padding(.top, 10)
            Spacer()
        }
    }
    
    func productScroll(productList: [String]) -> some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(productList, id: \.self) {products in
                    Image(products)
                        .frame(width: setWidth / 6, height: setWidth / 6, alignment: .center)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.leading, 18)
//        .padding(.top, 8)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
