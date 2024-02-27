//
//  NewConversationViewController.swift
//  Messagers
//
//  Created by Alexander on 09.02.2024.
//

import UIKit

class NewConversationViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Serach for users...."
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel" , style: .done, target: self, action: #selector(dismissSelf))
    }
    


}
extension NewConversationViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        <#code#>
    }
}
