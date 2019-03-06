//
//  Logger.swift
//  Chat
//
//  Created by Qurban on 15.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class Logger {
    static func log(_ text: String) {
        #if DEBUG
        print(text)
        #endif
    }
    
    static func logThemeChanging(selectedTheme: UIColor) {
        #if DEBUG
        print(selectedTheme)
        #endif
    }
}
