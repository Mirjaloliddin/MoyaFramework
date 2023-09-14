//
//  UserViewController.swift
//  UsingFrameworkMoya
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 14/09/23.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @IBAction func userButtonAction(_ sender: Any) {
        let vc = UserListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
