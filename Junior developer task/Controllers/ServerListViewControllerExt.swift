//
//  ServerListViewControllerExt.swift
//  Junior developer task
//
//  Created by Daniel Šuškevič on 2020-08-09.
//  Copyright © 2020 Daniel Šuškevič. All rights reserved.
//

import UIKit

extension ServerListViewController {
    func setConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().labeled("tableViewTop")
            make.bottom.equalToSuperview().labeled("tableViewBottom")
            make.leading.equalToSuperview().labeled("tableViewLeading")
            make.trailing.equalToSuperview().labeled("tableViewTrailing")
        }
    }
}

extension ServerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServerCell", for: indexPath)
        cell.textLabel?.text = SafeUnwrap.shared.safeUnwrapOfString(string: serverList[indexPath.row].name)
               
        return cell
    }
}
