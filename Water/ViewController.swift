//
//  ViewController.swift
//  Water
//
//  Created by Юрий Макаров on 01/11/2018.
//  Copyright © 2018 Юрий Макаров. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func `self`(_ sender: UIButton) {
        appDelegate.scheduleNotificationContent()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
