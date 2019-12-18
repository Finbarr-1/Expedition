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
    
    @IBAction func swipeReload(_ sender: Any) {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
           
           ActInd.startAnimating()
           
       }
       
       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           
           ActInd.stopAnimating()
           
       }
       
       func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
           
           ActInd.stopAnimating()
           
       }
}
