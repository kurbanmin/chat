//
//  netManager.swift
//  Chat
//
//  Created by Qurban on 14.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IDownloadManager {
    func downloadData(urlString: String, completion: @escaping (Result<Data>) -> Void)
}

class DownloadManager: IDownloadManager {
    static var shared = DownloadManager()

    var cachedData: [String: Data] = [:]

    func downloadData(urlString: String, completion: @escaping (Result<Data>) -> Void) {
        if let data = self.cachedData[urlString] {
            completion(Result.succes(data))
            return
        }

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                completion(Result.error(error.localizedDescription))
            }

            if let data = data {
                self?.cachedData[urlString] = data
                completion(Result.succes(data))
            }
        }

        task.resume()
    }
}
