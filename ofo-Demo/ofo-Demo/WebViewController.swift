//
//  WebViewController.swift
//  ofo-Demo
//
//  Created by 蔡四堂 on 2017/12/1.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView:WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //这个view的标题
        self.title = "热门活动"
        
        webView = WKWebView(frame:self.view.frame)
       
        view.addSubview(webView)
    
        let url = URL(string:"http://m.ofo.so/active.html")!
        let request = URLRequest(url:url)
        webView.load(request)

        
        

        // Do any additional setup after loading the view.
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
