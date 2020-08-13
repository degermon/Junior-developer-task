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
    
    var networkRequest: NetworkingProtocol!
    var serverList: [ServerList] = [] {
        didSet {
            serverList = serverList.sorted { SafeUnwrap.shared.safeUnwrapOfString(string: $0.name?.lowercased()) < SafeUnwrap.shared.safeUnwrapOfString(string: $1.name?.lowercased()) } // sort alphabetically
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
        networkRequest.getServersList(withToken: networkRequest.getToken(), url: UrlKeeper.serverListUrl) { result in
            switch result {
            case .failure(let error):
                print(error)
                self.noDataAlert()
            case .success(let list):
                self.serverList = list
            }
        }
    }
    
    // MARK: - Alerts
    
    func noDataAlert() {
        let alert = UIAlertController(title: "Error", message: "No data available", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
            self.getServersList()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
