//
//  AppDelegate.swift
//  Chat
//
//  Created by Qurban on 09.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

// * Параметр для включения/отключения логов
var showLogs = true

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var state: UIApplication.State = .inactive
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if showLogs {
            print("Application moved from \(string(from: state)) to \(string(from: application.applicationState)): \(#function)")
            state = application.applicationState
        }
       
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if showLogs {
            print("Application moved from \(string(from: state)) to \(string(from: application.applicationState)): \(#function)")
            state = application.applicationState
        }
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if showLogs {
            print("Application moved from \(string(from: state)) to \(string(from: application.applicationState)): \(#function)")
            state = application.applicationState
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if showLogs {
            print("Application moved from \(string(from: state)) to \(string(from: application.applicationState)): \(#function)")
            state = application.applicationState
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if showLogs {
            print("Application moved from \(string(from: state)) to \(string(from: application.applicationState)): \(#function)")
            state = application.applicationState
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if showLogs {
            print("Application moved from \(string(from: state)) to \(string(from: application.applicationState)): \(#function)")
            state = application.applicationState
        }
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
}

