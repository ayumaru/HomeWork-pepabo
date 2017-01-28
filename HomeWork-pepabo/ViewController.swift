//
//  ViewController.swift
//  HomeWork-pepabo
//
//  Created by 西村歩夢 on 2017/01/28.
//  Copyright © 2017年 西村歩夢. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // テーブル
    @IBOutlet weak var table: UITableView!
    
    // データ
    var name = Array<String>()
    var detail = Array<String>()
    
    // ページ
    var pageNum = 1
    
    // 表示数
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        // カスタムせる
        let nib = UINib(nibName: "LoadCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "LoadCell")
        
        // データ
        load(page: pageNum)
    }
    
    
    // データ読み込み
    func load(page: Int) {
        Alamofire.request("https://api.github.com/search/repositories?q=swift+language:swift&sort=stars&order=desc&page=" + String(page)).responseJSON { (response) in
            
            // nilチェック
            guard let object = response.result.value else {
                return
            }
            
            // ページ送り
            self.pageNum += 1
            
            // jsonに変換
            let json = JSON(object)
            print(json)
            
            // 取り出し
            for i in 0..<json["items"].count {
                
                self.name.append((json["items"][i]["name"]).string!)
                self.detail.append(json["items"][i]["updated_at"].string!)
                print(json["items"][i]["name"])
            }
            
            // 更新
            self.count += json["items"].count
            self.title = String(self.count)
            self.table.reloadData()
        }
    }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    // テーブル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 最後のセル
        if indexPath.row == count - 1{
            
            // データ読み込み
            self.load(page: pageNum)
            let loadCell = table.dequeueReusableCell(withIdentifier: "LoadCell")
            return loadCell!
        }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        // 表示
        cell.textLabel?.text = self.name[indexPath.row]
        cell.detailTextLabel?.text = detail[indexPath.row]
        return cell
    }
    
    // 新しいセル追加
    func addCell() {
        load(page: pageNum)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

