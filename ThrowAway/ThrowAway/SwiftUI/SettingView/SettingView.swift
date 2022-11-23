//
//  SettingView.swift
//  ThrowAway
//
//  Created by 이건우 on 2022/11/23.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    @ObservedObject var settingViewModel: SettingViewModel = SettingViewModel()
    private let SKStoreProductVC: SKStoreProductViewController = SKStoreProductViewController()
    
    var body: some View {
        VStack(spacing: 0) {
            
            SettingViewCell(title: "License", imageName: "chevron.right", isSystemName: true)
            Divider().padding(.horizontal, 22)
            
            SettingViewCell(title: "개발자 소개", imageName: "github")
            Divider().padding(.horizontal, 22)
            
            SettingViewCell(title: "개발자에게 커피 사주기", imageName: "buymeacoffee")
            Divider().padding(.horizontal, 22)
            
            HStack {
                Text("App version")
                
                Spacer()
                
                Button {
                    settingViewModel.openAppStoreView(SKStoreProductVC)
                } label: {
                    Text("업데이트")
                        .foregroundColor(.red)
                        .underline(color: .red)
                }
                .opacity(settingViewModel.updateIsAvailable ? 1 : 0)
                .disabled(settingViewModel.updateIsAvailable ? false : true)
                .padding(.trailing, 10)
                
                Text(settingViewModel.updateIsAvailable ? settingViewModel.appVersion ?? "-" : "\(settingViewModel.appVersion ?? "-") ✓")
                    .foregroundColor(.gray)
            }
            .settingViewCellStyle()
        }
        .navigationBarTitle("설정")
        
        Spacer()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
