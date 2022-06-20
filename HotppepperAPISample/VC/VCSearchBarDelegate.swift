//
//  VCSearch.swift
//  iOSEngineerCodeCheck
//
//  Created by 桑田翔平 on 2022/06/01.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension ViewController:UISearchBarDelegate{
    
    //検索バー編集開始時に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 検索バー入力開始時のテキストの設定
        searchBar.text = ""
        return true
    }
    //検索バー入力テキスト変更時に呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepoURLSessionTask?.cancel()
    }
    //検索ボタンpush時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text, searchBarText.count != 0 else{ return }
        
        searchRepoURLString = "https://api.github.com/search/repositories?q=\(searchBarText)"
        
        guard let searchRepoURL = URL(string: searchRepoURLString) else{ return }
        
        searchRepoURLSessionTask = URLSession.shared.dataTask(with: searchRepoURL) { (data, res, err) in
            guard let data = data else {
                return
            }
            
            do {
                //リポジトリデータJsonファイル取得
                guard let obj = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let items = obj["items"] as? [[String: Any]] else{ return }
                
                print(obj)
                print("ここっここっここっこ")
                print(items)
                self.repository = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                // エラーが発生した場合の処理
                self.correspondenceErrorAleart(title: "通信エラー発生", message: "通信環境の良い場所でもう一度お試しください")
            }
        }
        searchRepoURLSessionTask?.resume()
    }
    
    //エラー時のアラート関数
    func correspondenceErrorAleart(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
