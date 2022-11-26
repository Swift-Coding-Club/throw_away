//
//  Month.swift
//  ThrowAway
//
//  Created by 지준용 on 2022/11/05.
//

import SwiftUI

enum MonthType {
    case previousMonth
    case currentMonth
    case nextMonth
}

struct Month {
    var monthType: MonthType
    var dayInt: Int
}
