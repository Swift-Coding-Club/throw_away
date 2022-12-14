//
//  AppDelegate.swift
//  ThrowAway
//
//  Created by Sally on 2022/11/01.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigationBar()
        return true
    }
    
    func configureNavigationBar() {
        let barAppearance = UINavigationBar.appearance()
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            barAppearance.standardAppearance = appearance
            barAppearance.scrollEdgeAppearance = appearance
        } else {
            barAppearance.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
            barAppearance.shadowImage = UIImage()
        }
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
