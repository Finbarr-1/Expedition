//
//  OptionsViewController.swift
//  Expedition
//
//  Created by Julian Wright on 1/7/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import WebKit
import Foundation

class OptionsViewController: UIViewController {

    @IBOutlet weak var historySwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(historySwitch.isOn)
        
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(OptionsViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
        
        // Do any additional setup after loading the view.
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    @objc func defaultsChanged(){
        if let saveHistory:Bool = UserDefaults.standard.bool(forKey: "save_history") {
            
            historySwitch.setOn(saveHistory, animated: false)
        }
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
