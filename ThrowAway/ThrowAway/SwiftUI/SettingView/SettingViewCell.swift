//
//  SettingViewCellViewModifier.swift
//  ThrowAway
//
//  Created by 이건우 on 2022/11/23.
//

import SwiftUI

struct SettingViewCell: View {
    
    var title: String
    var imageName: String
    var isSystemName: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                
                Spacer()
                
                if isSystemName {
                    Image(systemName: imageName)
                } else {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
            }
            .settingViewCellStyle()
            
            Divider().padding(.horizontal, 22)
        }
    }
}

struct SettingViewCellStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 50)
            .padding(.horizontal, 22)
    }
}

extension View {
    func settingViewCellStyle() -> some View {
        modifier(SettingViewCellStyle())
    }
}
