//
//  ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 8/16/19.
//  Copyright © 2019 The Morning Company All rights reserved.
//
//

import UIKit
import WebKit
import Foundation

class ViewController: UIViewController, WKNavigationDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    var History: Array<Any>!
    var historyRuns = 0
    let credits: String = "Zeqe Golomb, Finbarr O'Connell, Jackson Yan, Julian Wright, Brendan Burkhart, Kai Morita-McVey"
    
    var components = URLComponents(string: "https://duckduckgo.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let searchEngine: String = "duckduckgo.com"
        
        let url = URL(string: "https://duckduckgo.com/")
        
        let request = URLRequest(url: url!)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "duckduckgo.com"
        
        webView.load(request)
        
        webView.addSubview(ActInd)
        ActInd.startAnimating()
        
        webView.navigationDelegate = self
        ActInd.hidesWhenStopped = true
    }
    
    
    @IBAction func back(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }

    @IBAction func forward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
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
    
    func verifyUrl (urlString: String?) -> Bool { //tests for url
        let url: URL?
        if urlString!.hasPrefix("http://") {
            url = URL(string: urlString!)
        } else {
            url = URL(string: "http://" + urlString!)
        }
        if let url = url {
            if (urlString!.contains(".")) {
                if (!urlString!.hasPrefix(".") && !urlString!.hasSuffix(".")) {
                    if (UIApplication.shared.canOpenURL(url)) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func historyOnOff() -> Bool {
        let historyOnOff = true
        return historyOnOff
    }

    func history(urlForHistory : String?) {
        if historyOnOff(){
            if (historyRuns == 0) {
                History = [urlForHistory!]
            } else {
                History.append(urlForHistory!)
            }
            historyRuns += 1
        }
    }
    
    func searchText(urlString: String) -> URLRequest {
        let queryItemQuery = URLQueryItem(name: "q", value: urlString);
        
        components?.queryItems = [queryItemQuery]
        
        let request = URLRequest(url: (components?.url)!)
        
        return request
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        var urlForHistory = searchBar.text
        history(urlForHistory : searchBar.text)
        
        searchBar.resignFirstResponder()
        
        if (verifyUrl(urlString: searchBar.text!)) {
            let url = URL(string: "http://\(searchBar.text!)")
            
            
            let request = URLRequest(url: url!)
            
            webView.load(request)
        }
        else {
            let queryItemQuery = URLQueryItem(name: "q", value: searchBar.text!);
            
            components?.queryItems = [queryItemQuery]
            
            let request = URLRequest(url: (components?.url)!)
            
            webView.load(request)
        }
          
    }
    
    
}
    
func DarkModeToggle(_ sender: Any) {
    
}
