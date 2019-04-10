//
//  RootAssembly.swift
//  
//
//  Created by Qurban on 09.04.2019.
//

import Foundation

class RootAssembly {
    lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(serviceAssembly: self.serviceAssembly)
    private lazy var serviceAssembly: IServicesAssembly = ServicesAssembley(coreAssembly: coreAssembly)
    private lazy var coreAssembly: ICoreAssembly = CoreAssembly()
}
