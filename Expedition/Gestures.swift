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

 
    @IBAction func swipeReload(_ sender: UIGestureRecognizer) {
        webView.reload()
    }
    
    @IBAction func igButton(_ sender: UIButton) {
        print ("\n\n\n----------------\nIGBUTTONPRESSED\n---------------- \n \n \n ")
        //let instagramHooks = "https://www.instagram.com/themorningcompanymedia/"
        guard let instagramUrl = URL(string: "https://www.instagram.com/themorningcompanymedia") else {
            return
        }
        if UIApplication.shared.canOpenURL(instagramUrl)
        {
            let request = URLRequest(url: instagramUrl)
            webView.load(request)
            
         } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.open(URL(string: "http://instagram.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
}
    

