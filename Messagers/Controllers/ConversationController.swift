//
//  ViewController.swift
//  Messagers
//
//  Created by Alexander on 09.02.2024.
//

import UIKit
import FirebaseAuth

class ConversationController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(noConversationLabel)
        setupTableView()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    private let noConversationLabel: UILabel = {
        let label = UILabel()
        label.text = "No Conversation!"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
       // let isloggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        private func validateAuth(){
            if FirebaseAuth.Auth.auth().currentUser == nil {
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
             }
           }
        }
       

