//
//  NewConversationViewController.swift
//  Messagers
//
//  Created by Alexander on 09.02.2024.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {

    
    private let spinner = JGProgressHUD()
    
    private var users = [[String: String]]()
    
    private var results = [[String: String]]()
    
    private var hasFetched = false
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Serach for users...."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       return table
    }()
    
    private let noresultLable: UILabel = {
        let lable = UILabel()
        lable.isHidden = true
        lable.text = "No Results"
        lable.textAlignment = .center
        lable.textColor = .green
        lable.font = .systemFont(ofSize: 21, weight: .medium)
        return lable
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel" , style: .done, target: self, action: #selector(dismissSelf))
        
        searchBar.becomeFirstResponder()
    }
    
   @objc private func dismissSelf() {
        dismiss(animated: true)
    }


}
extension NewConversationViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        
        results.removeAll()
        spinner.show(in: view)
        
        self.searchUsers(query: text)
        
    }
    
    func searchUsers(query: String) {
        // check if array has firebase
        if hasFetched {
            // if it does: filter
        }
        else {
            // if not fetch then filter
            DataBaseManager.shared.getAllUsers(completion: {[weak self] result in
                switch result {
                case .success(let usersCollection):
                    self?.users = usersCollection
                case .failure(let error):
                    print("Failed to get users: \(error)")
                }
            })
        }
        
        
        
        //update the UI: eiter show resalts
    }
    
    func filterUsers(with term: String){
        guard hasFetched else {
            return
        }
        let results: [[String: String]] = self.users.filter({
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            return name.hasPrefix(term.lowercased())
        })
        self.results = results
    }
}
