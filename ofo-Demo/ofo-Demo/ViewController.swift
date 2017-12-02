//
//  ViewController.swift
//  ofo-Demo
//
//  Created by 蔡四堂 on 2017/12/1.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit
import SWRevealViewController


class ViewController: UIViewController, MAMapViewDelegate {

    
    @IBOutlet weak var pantView: UIView!
    var mapView: MAMapView!
    
    
    @IBAction func locationBtnTap(_ sender: UIButton) {
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initmapView()
        setNavi()
        initrevealVC()
        view.bringSubview(toFront: pantView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    //初始化地图视图并获取当前定位
    func initmapView(){
        mapView = MAMapView(frame: self.view.bounds)
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
  
    }
    // 设置导航栏
    func setNavi(){
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "user_center_icon").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "gift_icon").withRenderingMode(.alwaysOriginal)
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "Login_Logo"))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    //创建并初始化侧滑容器
    func initrevealVC(){
        if let revealVC = revealViewController(){
            revealVC.rearViewRevealWidth = 310
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
            
            
        }
    }


}

