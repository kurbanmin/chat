//
//  ThemesViewController.swift
//  Chat
//
//  Created by Qurban on 06.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {

    var closure: ((UIColor) -> Void)?

    var model: Themes!

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func theme1Action(_ sender: UIButton) {
        self.closure?(self.model.theme1)
        view.backgroundColor = self.model.theme1
        navigationController?.navigationBar.barTintColor = self.model.theme1
    }

    @IBAction func theme2Action(_ sender: UIButton) {
        self.closure?(self.model.theme2)
        view.backgroundColor = self.model.theme2
        navigationController?.navigationBar.barTintColor = self.model.theme2
    }

    @IBAction func theme3Action(_ sender: UIButton) {
        self.closure?(self.model.theme3)
        view.backgroundColor = self.model.theme3
        navigationController?.navigationBar.barTintColor = self.model.theme3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let colorData = UserDefaults.standard.data(forKey: "Theme"),
            let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor {
            view.backgroundColor = color
        }
    }

}
