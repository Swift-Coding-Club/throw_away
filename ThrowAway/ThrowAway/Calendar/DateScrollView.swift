//
//  DateScrollView.swift
//  ThrowAway
//
//  Created by 지준용 on 2022/11/03.
//

import SwiftUI

struct DateScrollView: View {
    @EnvironmentObject var dateHolder: DateHolder
    let calendarHelper = CalendarHelper()
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                previousMonth()
            }, label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
            })
            
            Text(calendarHelper.monthYearString(dateHolder.date))
                .font(.title)
                .bold()
            
            Button(action: {
                nextMonth()
            }, label: {
                Image(systemName: "chevron.right")
                    .imageScale(.large)
            })
            
            Spacer()
        }
    }
    func previousMonth() {
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
    }
    
    func nextMonth() {
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
    }
}

struct DateScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollView()
    }
}
