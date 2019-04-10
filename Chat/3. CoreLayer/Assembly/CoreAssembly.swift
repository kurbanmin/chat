//
//  CoreAssembly.swift
//  Chat
//
//  Created by Qurban on 09.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
protocol ICoreAssembly {
    var storageManager: IStorageManager {get}
    var communicationManager: ICommunicationManager {get}
}

class CoreAssembly: ICoreAssembly {
    lazy var storageManager: IStorageManager = StorageManager.shared
    lazy var communicationManager: ICommunicationManager = CommunicationManager()
}
