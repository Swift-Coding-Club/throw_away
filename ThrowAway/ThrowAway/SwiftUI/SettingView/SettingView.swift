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
    private let githubURL: URL = URL(string: "https://github.com/Swift-Coding-Club/throw_away")!
    private let buymeacoffeeURL: URL = URL(string: "https://www.buymeacoffee.com/biumapp")!
    
    var body: some View {
        VStack(spacing: 0) {
            
            SettingViewCell(title: "License", imageName: "chevron.right", isSystemName: true)
            
            Link(destination: githubURL) {
                SettingViewCell(title: "개발자 소개", imageName: "github")
                    .foregroundColor(.black)
            }
            
            Link(destination: buymeacoffeeURL) {
                SettingViewCell(title: "개발자에게 커피 사주기", imageName: "buymeacoffee")
                    .foregroundColor(.black)
            }
            
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
