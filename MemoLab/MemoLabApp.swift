//
//  MemoLabApp.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 10/1/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}

@main
struct MemoLabApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var auth = UserAuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            LaunchView(auth: auth)
                .task {
                    await auth.isUserLoggedInAndVerified()
                }
        }
    }
}
