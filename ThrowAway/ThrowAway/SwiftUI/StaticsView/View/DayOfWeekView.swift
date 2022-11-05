//
//  DayOfWeekView.swift
//  ThrowAway
//
//  Created by 지준용 on 2022/11/04.
//

import SwiftUI

struct DayOfWeekView: View {
    var weeks = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        HStack {
            ForEach(weeks, id: \.self) { week in
                Text(week).dayOfWeek()
            }
        }
    }
}

struct DayOfWeekView_Previews: PreviewProvider {
    static var previews: some View {
        DayOfWeekView()
    }
}

extension Text {
    func dayOfWeek() -> some View {
        self
            .frame(maxWidth: .infinity)
            .lineLimit(1)
    }
}
