//
//  UserListViewController.swift
//  UsingFrameworkMoya
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 14/09/23.
//

import UIKit
import Moya

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    var userProvider = MoyaProvider<UserService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        getAPI()
    }
    
    func configureNavigationBar() {
        
        view.backgroundColor = .white
        let plus = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addClicked))
        navigationItem.rightBarButtonItem = plus
        title = "Users"
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getAPI() {
        userProvider.request(.readUser) { result in
            
            switch result {
            case .success(let response):
                let users = try! JSONDecoder().decode([User].self, from: response.data)
                self.users = users
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func addClicked(_ sender: UIBarButtonItem) {
        let addItem = User(id: 11, name: "Moya framework")
        userProvider.request(.createUser(name: addItem.name)) { result in
            switch result {
            case .success(let response):
                
                let newUser = try! JSONDecoder().decode(User.self, from: response.data)
                self.users.insert(newUser, at: 0)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        userProvider.request(.updateUser(id: user.id, name: "[Modified] " + user.name)) { result in
            switch result {
            case .success(let response):
                let modifiedUser = try! JSONDecoder().decode(User.self, from: response.data)
                self.users[indexPath.row] = modifiedUser
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        let user = users[indexPath.row]
        
        userProvider.request(.deleteUseer(id: user.id)) { result in
            switch result {
                
            case .success(let response):
                print("delete: \(response)")
                self.users.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
