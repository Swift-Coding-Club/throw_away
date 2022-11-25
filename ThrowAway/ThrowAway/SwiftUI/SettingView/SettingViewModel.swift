//
//  SettingViewModel.swift
//  ThrowAway
//
//  Created by 이건우 on 2022/11/23.
//

import SwiftUI
import StoreKit

final class SettingViewModel: ObservableObject {
    
    @Published var updateIsAvailable: Bool = false
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // TODO: - 앱 출시 후 추가해야 합니다.
    private let bundleID: String = ""   // ex) com.app.app
    private let appID: String = ""      // ex) 1234567890
    
    func checkAppVersion() async {
        guard
            let version = appVersion,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleID)"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let results = json["results"] as? [[String: Any]],
            results.count > 0,
            let appStoreVersion = results[0]["version"] as? String
        else {
            updateIsAvailable = false
            return
        }
        
        print(appStoreVersion, version)
        await MainActor.run {
            updateIsAvailable = !(version == appStoreVersion)
        }
    }
    
    func openAppStoreView(_ vc: SKStoreProductViewController) {
        let params = [SKStoreProductParameterITunesItemIdentifier: appID] as [String: Any]
        vc.loadProduct(withParameters: params, completionBlock: { (_, _) -> Void in
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            window?.rootViewController?.present(vc, animated: true, completion: nil)
        })
    }
}
