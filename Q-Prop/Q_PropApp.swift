//
//  Q_PropApp.swift
//  Q-Prop
//
//  Created by Matthew Grella on 4/24/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Q_PropApp: App {
    @StateObject var oddsFetcher = GameLinesModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            Main()
                .environmentObject(oddsFetcher)
        }
    }
}
