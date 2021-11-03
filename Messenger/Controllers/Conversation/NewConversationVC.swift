//
//  NewConversationVC.swift
//  Messenger
//
//  Created by Rakan Alqahtani  on 21/03/1443 AH.
//

import UIKit
import JGProgressHUD
class NewConversationVC: UIViewController {
 private let spinner = JGProgressHUD()
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users.. "
        return searchBar
        
    }()
    
    private let tableView : UITableView =
    {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf) )
        view.backgroundColor = .white
        
        searchBar.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func dismissSelf(){
        dismiss(animated: true , completion: nil)
    }
}

extension NewConversationVC : UISearchBarDelegate {
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
}
