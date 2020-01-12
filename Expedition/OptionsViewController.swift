//
//  OptionsViewController.swift
//  Expedition
//
//  Created by Julian Wright on 1/7/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import CoreData

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
    
    @IBAction func clearHistory(_ sender: UIButton) {
        let alert = UIAlertController(title: "Clear History", message: "Are you sure you want to clear history?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { action in
            self.doTheClearHistory()
        }))

        self.present(alert, animated: true)
    }
    
    @IBAction func clearBrowsingData(_ sender: UIButton) {
        let alert = UIAlertController(title: "Clear Browsing Data", message: "Are you sure you want to clear browsing data?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { action in
            self.doTheClearHistory()
            self.removeCookies()
        }))

        self.present(alert, animated: true)
    }
    
    func removeCookies(){
        // Remove all cache
        URLCache.shared.removeAllCachedResponses()

        // Delete any associated cookies
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                print("COOKIE: " + cookie.name)
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    
    func doTheClearHistory() {
        HistoryTableViewController().historyArray = [HistoryElement]()
        let fetchRequest: NSFetchRequest<HistoryElement> = HistoryElement.fetchRequest()
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
           for object in result {
               PersistenceService.context.delete(object)
           }
           PersistenceService.saveContext()
           HistoryTableViewController().tableView.reloadData()
        }
        print("history cleared", HistoryTableViewController().historyArray)
    }
    
    @IBAction func historySwitchValueChange(_ sender: Any) {
        UserDefaults.standard.set(historySwitch.isOn, forKey: "save_history")
        UserDefaults.standard.synchronize()
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
    
    @IBAction func didTapLightIcon(_ sender: UIButton) {
        UIApplication.shared.setAlternateIconName("LightIcon")
    }
    
    @IBAction func didTapDarkIcon(_ sender: UIButton) {
        UIApplication.shared.setAlternateIconName("DarkIcon")
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
