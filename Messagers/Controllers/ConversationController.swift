//
//  ViewController.swift
//  Messagers
//
//  Created by Alexander on 09.02.2024.
//

import UIKit

class ConversationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isloggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isloggedIn{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }

}

