//
//  IRequest.swift
//  Chat
//
//  Created by Qurban on 17.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class ImagesRequest: IRequest {
    private let baseUrl = "https://pixabay.com/api/"
    private let apiKey = "12176907-c7d2fc7f2785f8e621feff4cd"
    private var page: Int

    private var getParameters: [String: String] {
        return ["key": apiKey,
                "per_page": "20",
                "image_type": "photo",
                "pretty": "true",
                "page": "\(page)"]
    }

    private var urlString: String {
        let getParams = getParameters.compactMap({ "\($0.key)=\($0.value)"}).joined(separator: "&")
        return baseUrl + "?" + getParams
    }

    var urlRequest: URLRequest? {
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        return nil
    }

    init(page: Int) {
        self.page = page
    }
}
