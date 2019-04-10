//
//  Profile.swift
//  Chat
//
//  Created by pro on 12/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var name: String?
    var description: String?
    var image: UIImage?

    init(name: String? = nil, description: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.description = description
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case image
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try? container.encode(name, forKey: .name)
        try? container.encode(description, forKey: .description)

        let data = image?.pngData()
        try? container.encode(data, forKey: .image)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try? container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)

        let data = try? container.decode(Data.self, forKey: .image)

        if let data = data {
            self.image = UIImage(data: data)
        }
    }
}
