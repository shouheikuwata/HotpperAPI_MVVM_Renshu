//
//  VCTableVi.swift
//  iOSEngineerCodeCheck
//
//  Created by 桑田翔平 on 2022/06/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
extension ViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let rp = repository[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        tableViewSelectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
