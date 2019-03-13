//
//  OperationDataManager.swift
//  Chat
//
//  Created by Qurban on 13/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation



class OperationDataManager: DataManagerProtocol {
    let operationQueue = OperationQueue()
    
    func loadProfile(completion: @escaping (Profile?) ->()) {
        let loadOperation = LoadOperation()
        
        loadOperation.completionBlock = {
            OperationQueue.main.addOperation {
                completion(loadOperation.profile)
            }
        }
        
        operationQueue.addOperation(loadOperation)
    }
    
    func save(profile: Profile, completion: @escaping (Bool) -> ()) {
        let saveOperation = SaveOperation(profile: profile)
        
        saveOperation.completionBlock = {
            if saveOperation.success == true {
                OperationQueue.main.addOperation {
                    completion(true)
                }
            } else {
                OperationQueue.main.addOperation {
                    completion(false)
                }
            }
        }
        
        operationQueue.addOperation(saveOperation)
    }
}
