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
    }
}
