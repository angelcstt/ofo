//
//  SettingController.swift
//  ofo-Demo
//
//  Created by macosx on 2017/12/2.
//  Copyright © 2017年 angelcstt. All rights reserved.
//

import UIKit
import SWRevealViewController

class SettingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let revealVC = revealViewController() {
            navigationItem.leftBarButtonItem?.target = revealVC
            revealVC.rearViewRevealWidth = 310
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }

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
