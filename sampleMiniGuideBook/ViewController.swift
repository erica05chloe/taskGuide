//
//  ViewController.swift
//  sampleMiniGuideBook
//
//  Created by erica chloe on 2017/09/12.
//  Copyright © 2017年 erica chloe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
 
    
    //紹介したいエリア名が格納される配列
    var placeList:[String] = []
    //選択された行の表示エリア名（番号の時）
    var selectedName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "guideList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile:filePath!)
        
        //TableViewで扱いやすい形(エリア名の入っている配列)を作成
        //Dictionary型の高速列挙
        for(key,data) in dic! {
            print(key) //アヤラとか地名が取得できているか確認
            placeList.append(key as! String)
      }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字を表示するセルの取得(セルの再利用)
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = placeList[indexPath.row]
        return cell
        
    }
    //セグエを指定して画面遷移
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("\(indexPath.row)行目がタップされました")
            
            //選択されたエリア名を保存
            selectedName = placeList[indexPath.row]

            
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prepareの中では、移動元の画面、移動先の画面、どちらも操作が可能
        //移動先の画面に渡したい情報をセットできる
        //dv　今から移動する画面のオブジェクト(インスタンス)
        //segue.destination セグエを使って移動する先
        //as! ダウンキャスト変換するための記号
        //any型(なんでもいける型) からas!　を使って型をしっかり指定する
        let dv:SecondViewController = segue.destination as! SecondViewController
        
        dv.scSelectedName = selectedName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
