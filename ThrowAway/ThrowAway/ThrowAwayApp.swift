//
//  ThrowAwayApp.swift
//  ThrowAway
//
//  Created by 이건우 on 2022/10/22.
//

import SwiftUI

@main
struct ThrowAwayApp: App {
    let persistenceController = PersistenceController.shared
    let dateHolder = DateHolder()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
