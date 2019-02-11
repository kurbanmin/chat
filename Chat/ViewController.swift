//
//  ViewController.swift
//  Chat
//
//  Created by Qurban on 09.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if showLogs {
            print(#function)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showLogs {
            print(#function)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if showLogs {
            print(#function)
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if showLogs {
            print(#function)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if showLogs {
            print(#function)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if showLogs {
            print(#function)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if showLogs {
            print(#function)
        }
    }

}

