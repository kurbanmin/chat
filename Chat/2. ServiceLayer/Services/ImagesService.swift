//
//  ImagesService.swift
//  Chat
//
//  Created by Qurban on 12.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IImagesService {
    func loadImages<T>(page: Int, completion: @escaping (Result<T>) -> Void) where T: Codable
}

class ImagesService: IImagesService {
    let networkManager: INetworkManager

    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }

    func loadImages<T>(page: Int, completion: @escaping (Result<T>) -> Void) where T: Codable {
        let imagesRequest = ImagesRequest(page: page)

        networkManager.perform(with: imagesRequest) { (result: Result<T>) in
            completion(result)
        }
    }
}
