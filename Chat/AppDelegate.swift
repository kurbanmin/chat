//
//  AppDelegate.swift
//  Chat
//
//  Created by Qurban on 09.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let rootAssembley = RootAssembly()
    var oldState: UIApplication.State = .inactive

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Logger.log(strigfrom(oldState: &oldState, newState: application.applicationState, functionName: #function))

        if let colorData = UserDefaults.standard.data(forKey: "Theme"),
            let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor {
            UINavigationBar.appearance().barTintColor = color
        }

        self.window = EmitterWindow(frame: UIScreen.main.bounds)

        if let conversationListVC = rootAssembley.presentationAssembly.conversationsListVC() {
            let navigationController = UINavigationController(rootViewController: conversationListVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Logger.log(strigfrom(oldState: &oldState, newState: application.applicationState, functionName: #function))
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Logger.log(strigfrom(oldState: &oldState, newState: application.applicationState, functionName: #function))
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Logger.log(strigfrom(oldState: &oldState, newState: application.applicationState, functionName: #function))
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Logger.log(strigfrom(oldState: &oldState, newState: application.applicationState, functionName: #function))
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Logger.log(strigfrom(oldState: &oldState, newState: application.applicationState, functionName: #function))
    }

    func string(from state: UIApplication.State) -> String {
        switch state {
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .background:
            return "Background"
        }
    }

    func strigfrom(oldState: inout UIApplication.State, newState: UIApplication.State, functionName: String) -> String {
        let result = "Application moved from \(string(from: oldState)) to \(string(from: newState)): \(functionName)"
        oldState = newState
        return result
    }
}
