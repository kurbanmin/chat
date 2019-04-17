//
//  PresentationAssembly.swift
//  Chat
//
//  Created by Qurban on 07.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
protocol IPresentationAssembly {
    func profileNC() -> UINavigationController?
    func conversationVC(conversationObject: ConversationObject) -> ConversationViewController?
    func conversationsListVC() -> ConversationsListViewController?
    func imagesVC() -> ImagesViewController?
}

class PresentationAssembly: IPresentationAssembly {

    private let serviceAssembly: IServicesAssembly

    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }

    func conversationVC(conversationObject: ConversationObject) -> ConversationViewController? {
        let model = ConversationModel(mcService: serviceAssembly.mcService)
        let storyboard = UIStoryboard(name: "Conversation", bundle: nil)
        let conversationVC = storyboard.instantiateViewController(withIdentifier: "ConversationViewController"
            ) as? ConversationViewController

        conversationVC?.conversationObject = conversationObject
        conversationVC?.configure(conversationModel: model, presentationAssembly: self)
        model.delegate = conversationVC

        return conversationVC
    }

    func conversationsListVC() -> ConversationsListViewController? {
        let model = ConversationsListModel(mcService: serviceAssembly.mcService)
        let storyboard = UIStoryboard(name: "Conversation", bundle: nil)
        let conversationListVC = storyboard.instantiateViewController(
                withIdentifier: "ConversationsListViewController"
            ) as? ConversationsListViewController

        conversationListVC?.configure(
            conversationsListModel: model,
            presentationAssembly: self)
        model.delegate = conversationListVC

        return conversationListVC
    }

    func profileNC() -> UINavigationController? {
        let model = ProfileModel(profileService: serviceAssembly.profileService)
        let storyboard = UIStoryboard(
            name: "Profile",
            bundle: nil
        )
        let profileNC = storyboard.instantiateViewController(
            withIdentifier: "ProfileNavigationController"
            ) as? UINavigationController

        let profileVC = profileNC?.topViewController as? ProfileViewController
        profileVC?.configure(profileModel: model, presentationAssembly: self)
        model.delegate = profileVC

        return profileNC
    }

    func imagesVC() -> ImagesViewController? {
        let model = ImagesModel(imagesService: serviceAssembly.imagesService)
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let imagesVC = storyboard.instantiateViewController(
            withIdentifier: "ImagesViewController") as? ImagesViewController
        imagesVC?.configure(imagesModel: model, presentationAssembly: self)
        model.delegate = imagesVC
        return imagesVC
    }
}
