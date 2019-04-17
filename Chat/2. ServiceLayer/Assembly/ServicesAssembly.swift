//
//  ServicesAssembly.swift
//  Chat
//
//  Created by Qurban on 07.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IServicesAssembly {
    var mcService: IMCService { get }
    var profileService: IProfileService { get }
    var imagesService: IImagesService { get }
}

class ServicesAssembley: IServicesAssembly {
    private let coreAssembly: ICoreAssembly

    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }

    lazy var mcService: IMCService = MCServise(communicationManager: self.coreAssembly.communicationManager,
                                               storageManager: self.coreAssembly.storageManager)
    lazy var profileService: IProfileService = ProfileService(storageManager: coreAssembly.storageManager)
    lazy var imagesService: IImagesService = ImagesService(networkManager: coreAssembly.networkManager)
}
