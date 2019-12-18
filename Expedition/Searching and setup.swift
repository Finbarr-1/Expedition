//
//  ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 8/16/19.
//  Copyright © 2019 The Morning Company All rights reserved.

import UIKit
import WebKit
import Foundation

class ViewController: UIViewController, WKNavigationDelegate, UISearchBarDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    
    var History: Array<Any>! //history Array initialization
    var historyRuns = 0 //history runs initialization
    let credits: String = "Zeqe Golomb, Finbarr O'Connell, Jackson Yan, Julian Wright, Brendan Burkhart, Kai Morita-McVey, Sir Flansi" //Credits
    var searchEngine: String = "https://duckduckgo.com/" //Search engine initialization
    var components = URLComponents(string: "https://duckduckgo.com/") //search engine
    var historyOnOff: Bool!
    
    @IBOutlet weak var historySwitch: UISwitch!
    
    override func viewDidLoad() { //Setup stuff
        super.viewDidLoad()
        
        historySwitch?.setOn(historyOnOff ?? true, animated: false)
        
        var components = URLComponents(string: searchEngine)
        
        let url = URL(string: "https://duckduckgo.com/")
        
        let request = URLRequest(url: url!)
        
        components?.scheme = "https"
        components?.host = "duckduckgo.com"
        
        webView?.load(request)
        
        webView?.addSubview(ActInd)
        ActInd?.startAnimating()
        
        webView?.navigationDelegate = self
        ActInd?.hidesWhenStopped = true
    }
    
    
    
    
    func verifyUrl (urlString: String?) -> Bool { //tests for url
        let url: URL?
        if urlString!.hasPrefix("http://") {
            url = URL(string: urlString!)
        } else {
            url = URL(string: "http://" + urlString!)
        }
        if let url = url {
            if (urlString!.contains(".") && !(urlString!.hasPrefix(".")) && !(urlString!.hasSuffix("."))) {
                if (UIApplication.shared.canOpenURL(url)) {
                    return true
                }
            }
        }
            return false
    }
    
    
    
    @IBAction func historySwitch(_ sender: UISwitch) {
        if (historyOnOff == true) {
                historyOnOff = false
        } else {
            historyOnOff = true
        }
    }
    
    
    
    func history(urlForHistory : String?) { //adds stuff to the history array
        historyOnOff = historySwitch.isOn
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
