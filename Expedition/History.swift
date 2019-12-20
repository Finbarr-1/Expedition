//
//  History.swift
//  Expedition
//
//  Created by Finbarr O'Connell on 12/20/19.
//  Copyright © 2019 Zeqe Golomb. All rights reserved.
//

import Foundation
import WebKit
import UIKit

class History: UIViewController, WKNavigationDelegate, UISearchBarDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var historyOnOff: Bool!
    historySwitch.setOn(historyOnOff ?? true, animated: false)
    
    func history(urlForHistory : String?) { //adds stuff to the history array
        historyOnOff? = historySwitch.isOn
    }
    
    @IBAction func historySwitch(_ sender: UISwitch) {
        if (historyOnOff == true) {
                historyOnOff = false
        } else {
            historyOnOff = true
        }
    }
    
    
}
