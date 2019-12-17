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
    

    let appIconService = AppIconService()
    //app icon changer
    
    @IBAction func didTapPrimaryIcon() {
        appIconService.changeAppIcon(to: .primaryAppIcon)
    
    }
    //should change to light icon
    @IBAction func didTapDarkIcon() {
        appIconService.changeAppIcon(to: .DarkAppIcon)
    
    }
     //should change to dark icon
    

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    var History: Array<Any>! //history Array initialization
    var historyRuns = 0 //history runs initialization
    let credits: String = "Zeqe Golomb, Finbarr O'Connell, Jackson Yan, Julian Wright, Brendan Burkhart, Kai Morita-McVey" //Credits
    var searchEngine: String = "https://duckduckgo.com/" //Search engine initialization
    
    
    var components = URLComponents(string: "https://duckduckgo.com/") //search engine
    
    override func viewDidLoad() {
        super.viewDidLoad() //setup stuff
        
        var components = URLComponents(string: searchEngine)
        
        let url = URL(string: "https://duckduckgo.com/")
        
        let request = URLRequest(url: url!)
        
        components?.scheme = "https"
        components?.host = "duckduckgo.com"
        
        webView.load(request)
        
        webView.addSubview(ActInd)
        ActInd.startAnimating()
        
        webView.navigationDelegate = self
        ActInd.hidesWhenStopped = true
    }
    
    
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
    
    @IBAction func swipeReload(_ sender: Any) { //makes the page reload on downward swipe on searchbar
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
                if (!(urlString!.hasPrefix(".")) && !(urlString!.hasSuffix("."))){
                    if (UIApplication.shared.canOpenURL(url)) {
                        return true
                    }
                }
            }
            return false
        }
        return false
    }
    func historyOnOff() -> Bool { //will be connected to a switch turning tracking on and off
        let historyOnOff = true
        return historyOnOff
    }

    func history(urlForHistory : String?) { //adds stuff to the history array
        if historyOnOff(){
            if (historyRuns == 0) {
                History = [urlForHistory!]
            } else {
                History.append(urlForHistory!)
            }
            historyRuns += 1
        }
    }
    
    func searchText(urlString: String) -> URLRequest { //julian please explain
        let queryItemQuery = URLQueryItem(name: "q", value: urlString);
        
        components?.queryItems = [queryItemQuery]
        
        let request = URLRequest(url: (components?.url)!)
        
        return request
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //turns the users input into something that the search engine can use
        
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
            
            var urlForHistory = request // it is used ignore ->
            history(urlForHistory : searchBar.text)
                        
            webView.load(request)
        }
          
    }
}
    
func DarkModeToggle(_ sender: Any) { //turns dark mode on and off
    
}



