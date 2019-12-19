//
//  Gestures.swift
//  Expedition
//
//  Created by Finbarr O'Connell on 12/16/19.
//  Copyright © 2019 Zeqe Golomb. All rights reserved.
//
import WebKit
import UIKit

class Gestures : WKWebView, WKNavigationDelegate{
     @IBOutlet weak var webView: WKWebView!
     @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    
    @IBAction func back(_ sender: Any) { //makes the page go back if it can
        if webView.canGoBack{
            webView.goBack()
        }
    }

    @IBAction func forward(_ sender: Any) { //makes the page go forward if it can
        if webView.canGoForward{
            webView.goForward()
        }
    }

    
    @IBAction func refresh(_ sender: Any) { //makes the page reload
        webView.reload()
    }
 
    @IBAction func reload(_ sender: Any) {
        webView.reload()
    }
   
    
    @IBAction func swipeReload(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func igButton(_ sender: UIButton) {
        var instagramHooks = "instagram://user?username=johndoe"
        var instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.openURL(instagramUrl! as URL)

         } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "http://instagram.com/")! as URL)
        }

     }
    
    
    }
    

