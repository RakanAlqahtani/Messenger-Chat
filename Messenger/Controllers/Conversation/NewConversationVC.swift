//
//  NewConversationVC.swift
//  Messenger
//
//  Created by Rakan Alqahtani  on 21/03/1443 AH.
//

import UIKit
import JGProgressHUD
import SwiftUI
class NewConversationVC: UIViewController {
    public var completion: (([String:String]) -> (Void))?
    private let spinner = JGProgressHUD(style: .dark)
    private var users = [[String:String]]()
    private var results = [[String:String]]()

    private var hasFetched = false
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
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21, weight : .medium)
        return label

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noResultsLabel)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf) )
        view.backgroundColor = .white
        
        searchBar.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noResultsLabel.frame = CGRect(x: view.frame.size.width/4,
                                      y: (view.frame.size.height-200)/2,
                                      width: view.frame.size.width/2,
                                      height: 100)
    }
    
    @objc private func dismissSelf(){
        dismiss(animated: true , completion: nil)
    }
}


extension NewConversationVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]["name"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let targetUserData = results[indexPath.row]
        dismiss(animated: true) { [weak self] in
            self?.completion?(targetUserData)

        }
    }
}


extension NewConversationVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text , !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
            
        }
        searchBar.resignFirstResponder()
        results.removeAll()
        spinner.show(in: view)
        self.searchUsers(query: text)
    }
    
    func searchUsers(query : String){
        if hasFetched {
            self.filterUsers(with: query)
            
        } else {
            
            DatabaseManger.shared.getAllUsers {[weak self] results in
                
                switch results{
                case .success(let userCollection):
                    self?.hasFetched = true
                    self?.users = userCollection
                    self?.filterUsers(with: query)

                case .failure(let error):
                    print("not fetch \(error)")
                }
            
                
            }
        }
    }
    
    func filterUsers(with term: String){
        guard hasFetched else {
            return
        }
        
        self.spinner.dismiss()
        let results : [[String:String]] = self.users.filter({
            guard let name = $0["name"]?.lowercased() else {
                return false
            }
            return name.hasPrefix(term.lowercased())
        })
        self.results = results
        
        updateUI()
    }
    
    func updateUI(){
        if results.isEmpty {
            self.noResultsLabel.isHidden = false
            self.tableView.isHidden = true
        }
        else
        {
            self.noResultsLabel.isHidden = true
            self.tableView.isHidden = false
            tableView.reloadData()
        }
    }
}
