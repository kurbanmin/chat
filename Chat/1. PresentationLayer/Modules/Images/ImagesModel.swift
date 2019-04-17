//
//  ImagesModel.swift
//  Chat
//
//  Created by Qurban on 13.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IImagesModel {
    var delegate: IImagesModelDelegate? {get}
}

protocol IImagesModelDelegate: class {
    func setup(hits: [Hit])
}

class ImagesModel: IImagesModel {
    weak var delegate: IImagesModelDelegate?

    let imagesService: IImagesService

    init(imagesService: IImagesService) {
        self.imagesService = imagesService
    }

    func loadImages(page: Int) {
        imagesService.loadImages(page: page) { [weak self] (result: Result<ImagesResponse>) in
            switch result {
            case .succes(let imagesResponse):
                DispatchQueue.main.async {
                    self?.delegate?.setup(hits: imagesResponse.hits)
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
