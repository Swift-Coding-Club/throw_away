//
//  CalendarView.swift
//  ThrowAway
//
//  Created by 지준용 on 2022/11/04.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @State private var selection: Bool = false
    @State private var date = Date()
    let calendarManager = CalendarManager()

    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Product.cleaningDay, ascending: true)])
    var products: FetchedResults<Product>
    
    var body: some View {
        VStack {
            let firstDayOfMonth = calendarManager.firstOfMonth(dateHolder.date)
            let startingSpaces = calendarManager.weekDay(firstDayOfMonth)
            let daysInMonth = calendarManager.daysInMonth(dateHolder.date)
            let prevMonth = calendarManager.minusMonth(dateHolder.date)
            let daysInPrevMonth = calendarManager.daysInMonth(prevMonth)

            // TODO: - today를 Coredata 날짜로 수정하여 비움일을 표시

//            let cleaningDay = calendarManager.today(Date())
//            let yearMonth = calendarManager.yearMonth(Date())

            ForEach(0..<6) { row in
                HStack {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        let day = String(count-startingSpaces)
                        
                        CalendarCell(count: count,
                                     startingSpaces: startingSpaces,
                                     daysInMonth: daysInMonth,
                                     daysInPrevMonth: daysInPrevMonth,
                                     column: column
                        )
//                        .background(cleaningDay == yearMonth + day ? Color.green : Color.white)
                        .environmentObject(dateHolder)
                    }
                }
            }
        }
    }
}

struct CalendarCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    let column: Int
    @State private var selection = false
    
    var body: some View {
        Text(String(month().dayInt))
            .foregroundColor(textColors(type: month().monthType))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                selection.toggle()
            }
    }
    
    func textColors(type: MonthType) -> Color {
        if selection {
            return .white
        } else if column == 7 {
            return .blue
        } else if column == 1 {
            return .red
        } else {
            return type == MonthType.currentMonth ? .black : .gray
        }
    }
    
    func month() -> Month {
        let start = (startingSpaces == 0) ? startingSpaces + 7 : startingSpaces
        if count <= start {
            let day = daysInPrevMonth + count - start
            return Month(monthType: MonthType.previousMonth, dayInt: day)
            
        } else if count - start > daysInMonth {
            let day = count - start - daysInMonth
            return Month(monthType: MonthType.nextMonth, dayInt: day)
        }
        let day = count - start
        return Month(monthType: MonthType.currentMonth, dayInt: day)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
