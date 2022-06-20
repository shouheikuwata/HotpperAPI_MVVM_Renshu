//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var repositorySearchBar: UISearchBar!
    
    var repository: [[String: Any]] = []
    
    var searchRepoURLSessionTask: URLSessionTask?
    var searchRepoURLString: String!
    var tableViewSelectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        repositorySearchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        repositorySearchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let detailViewController = segue.destination as! ViewController2
            detailViewController.preveiousViewController = self
        }
        
    }
    
}
