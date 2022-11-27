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
    let screenWidth = UIScreen.main.bounds.width
    
    @EnvironmentObject var dateHolder: DateHolder
    
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
            
            ProductArrayView(text: "버리지 못한 물건", productArray: notThrowArray)
            ProductArrayView(text: "늦게 버린 물건", productArray: lateThrowArray)
        }
    }
    
    func ProductArrayView(text: String, productArray: [String]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(text)(\(productArray.count))")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                Spacer()
            }
            productScroll(productArray: productArray)
        }
        .padding(.leading, 16)
    }
    
    func productScroll(productArray: [String]) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(productArray, id: \.self) {product in
                    Image(product)
                        .resizable()
                        .frame(width: screenWidth / 6, height: screenWidth / 6, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                }
            }
        }
    }
}
