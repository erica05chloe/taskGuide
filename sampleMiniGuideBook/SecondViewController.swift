//
//  SecondViewController.swift
//  sampleMiniGuideBook
//
//  Created by erica chloe on 2017/09/13.
//  Copyright © 2017年 erica chloe. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {

    //選択されたエリア名を保存するプロパティ
    var scSelectedName = ""
    
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("選択されたエリアは\(scSelectedName)です")
        // Do any additional setup after loading the view.
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource: "guideList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile:filePath!)
        
        print(dic?[scSelectedName])
        
        //TODO
        //型変換におすすめな関数はatof()
        //String型->Double型
        
        for(key,data) in dic!{
            let dicForData:NSDictionary = data as! NSDictionary
            if((key as! NSString) as String == scSelectedName){
                navigationItem.title = scSelectedName
                myTextView.text = dicForData["description"] as! String
                myImageView.image = UIImage(named:dicForData["image"] as! String)
                
                let latitude:String = dicForData["latitude"] as! String
                let longitude:String = dicForData["longitude"] as! String
                
                let coordinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
                let span = MKCoordinateSpanMake(0.04, 0.04)
                let region = MKCoordinateRegionMake(coordinate, span)
                myMap.setRegion(region, animated:true)
                
        //ピンを生成
        let myPin: MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = coordinate
        myPin.title = scSelectedName
       // myPin.subtitle = "おすすめ"
        myMap.addAnnotation(myPin)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
