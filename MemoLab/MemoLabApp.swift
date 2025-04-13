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
    
    @StateObject var auth = UserAuthViewModel()
    @StateObject var data = DBViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            QuoteDataModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView(auth, data)
            .task {
                await auth.isUserLoggedInAndVerified()
            }
        }
        .modelContainer(sharedModelContainer)

    }
}
