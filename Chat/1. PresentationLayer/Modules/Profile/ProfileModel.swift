//
//  ProfileModel.swift
//  
//
//  Created by Qurban on 09.04.2019.
//

import Foundation

protocol IProfileModel {
    var delegate: IProfileModelDelegate? {get set}
    func save(profile: Profile)
    func getProfile()
}

protocol IProfileModelDelegate: class {
    func setup(profile: Profile)
    func show(error message: String)
    func didSave()
}

class ProfileModel: IProfileModel {
    weak var delegate: IProfileModelDelegate?

    var profileService: IProfileService

    init(profileService: IProfileService) {
        self.profileService = profileService
    }

    func getProfile() {
        profileService.getProfile { [weak self] profile in
            guard let profile = profile else { return }
            self?.delegate?.setup(profile: profile)
        }
    }

    func save(profile: Profile) {
        profileService.save(profile: profile) { [weak self] in
            self?.delegate?.didSave()
        }
    }
}
