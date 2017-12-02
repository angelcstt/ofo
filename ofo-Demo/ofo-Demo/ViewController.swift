//
//  ViewController.swift
//  ofo-Demo
//
//  Created by 蔡四堂 on 2017/12/1.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit
import SWRevealViewController


class ViewController: UIViewController, MAMapViewDelegate ,AMapSearchDelegate{
    //地图视图
    var mapView: MAMapView!
    //搜索
    var search: AMapSearchAPI!
    
    //本人地址标识
    let locationR = MAUserLocationRepresentation()
    //可操作子视图
    @IBOutlet weak var pantView: UIView!
    //定位按钮
    @IBAction func locationBtnTap(_ sender: UIButton) {
        searchBikeNearBy()
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
        mapView.zoomLevel = 18
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        changeLocationIcon()
        initSearch()
        mapView.update(locationR)
        
  
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
    //更改定位图标
    func changeLocationIcon(){
        locationR.showsAccuracyRing = false
        //locationR.lineWidth = 20
        //locationR.fillColor = UIColor.blue
        //locationR.strokeColor = UIColor.yellow
        //locationR.enablePulseAnnimation = true
        locationR.image = UIImage(named:"homePage_wholeAnchor")
    }
    //初始化搜索
    func initSearch(){
        search = AMapSearchAPI()
        search.delegate = self
        
    }
    //搜索附近的小黄车
    func searchBikeNearBy(){
        searchCoustomType(mapView.userLocation.coordinate)
    }
    //设置检索参数
    func searchCoustomType(_ center: CLLocationCoordinate2D) {
        let request = AMapPOIAroundSearchRequest()
        //request.tableID = TableID
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        request.keywords = "餐馆"
        request.radius = 500
        request.requireExtension = true
        search.aMapPOIAroundSearch(request)
    }
    //处理检索到的数据
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        guard response.count > 0 else {
            print("抱歉，附近没有小黄车！")
            return
        }
        //遍历搜到的结果，打印名字
//        for poi in response.pois {
//         print(poi.name)
//        }
        
        //转化后的检索得到的pois结果数组
        var annotations: [MAPointAnnotation] = []
        annotations = response.pois.map{
            
            let annotation = MAPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: (CLLocationDegrees($0.location.latitude)), longitude: CLLocationDegrees($0.location.longitude))
                //判断是否红包车
            if $0.distance < 50{
                annotation.title = "红包车辆"
                annotation.subtitle = "骑行十分钟可以领取红包"
            }else{
                annotation.title = "正常车辆"
                annotation.subtitle = "看我云长千里走单骑"
                 }
            return annotation
        }
        
            mapView.addAnnotations(annotations)
            mapView.showAnnotations(annotations, animated: true)
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        //判断是否是用户位置
        if annotation is MAUserLocation{
            return nil
        }
        let reusid = "myid"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reusid)as?MAPinAnnotationView
        if annotationView == nil{
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reusid)
            if annotation.title == "正常车辆"{
                annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
            }else{
                annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
            }
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
        }
        
        return annotationView
    }
   
    
}

