//
//  CalendarView.swift
//  ThrowAway
//
//  Created by 지준용 on 2022/11/04.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @State private var selection: Bool? = false
    @State private var columnIndex = 0
    @State private var rowIndex = 0
    
    var body: some View {
        VStack {
            let firstDayOfMonth = CalendarManager().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarManager().weekDay(firstDayOfMonth)
            let daysInMonth = CalendarManager().daysInMonth(dateHolder.date)
            let prevMonth = CalendarManager().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarManager().daysInMonth(prevMonth)
            
            ForEach(0..<6) { row in
                HStack {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        CalendarCell(count: count,
                                     startingSpaces: startingSpaces,
                                     daysInMonth: daysInMonth,
                                     daysInPrevMonth: daysInPrevMonth
                        )
                        .background(Color.green)
                        .onTapGesture{
                            
                            // TODO: - selection된 것에 따라 팝업 띄우기
                            
                            self.selection = true
                            
                            // TODO: - 선택한 날짜
                            
                            self.rowIndex = row
                            self.columnIndex = column
                            print([rowIndex, columnIndex])
                            print(count - startingSpaces)
                        }
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
    
    var body: some View {
        Text(String(month().dayInt))
            .foregroundColor(textColor(type: month().monthType))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func textColor(type: MonthType) -> Color {
        return type == MonthType.currentMonth ? .black : .gray
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
