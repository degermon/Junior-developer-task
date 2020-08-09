//
//  ServerListViewController.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import UIKit

class ServerListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var token: String = ""
    var serverList: [ServerList] = [] {
        didSet {
            serverList = serverList.sorted { SafeUnwrap.shared.safeUnwrapOfString(string: $0.name?.lowercased()) < SafeUnwrap.shared.safeUnwrapOfString(string: $1.name?.lowercased()) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setConstraints()
        setTitle()
        getServersList()
    }
    
    // MARK: - Config
    
    private func setTitle() {
        self.title = "Servers list"
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getServersList() {
        let tesoDataRequest = TesoRequest()
        tesoDataRequest.getServersList(withToken: token) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let list):
                self.serverList = list
            }
        }
    }
}
