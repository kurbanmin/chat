//
//  UIImageViewExtension.swift
//  Chat
//
//  Created by Qurban on 17.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(url: String, completion: @escaping (UIImage?, String?, String) -> Void) {
        DownloadManager.shared.downloadData(urlString: url) { (result: Result<Data>) in
            switch result {
            case .succes(let data):
                if let image = UIImage(data: data) {
                    completion(image, nil, url)
                } else {
                    completion(nil, "Wrong data", url)
                }
            case .error(let error):
                completion(nil, error, url)
            }
        }
    }
}
