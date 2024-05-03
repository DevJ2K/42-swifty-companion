//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 22/04/2024.
//

import SwiftUI

// Lock the orientation to Portrait mode
func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue)
}

//// Lock the orientation to Landscape(Horizontal) mode
//func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//    return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.landscape.rawValue)
//}

@main
struct swifty_companionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
