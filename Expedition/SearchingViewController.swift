//
//  ViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 8/16/19.
//  Copyright © 2019-2020 The Morning Company All rights reserved.

import UIKit
import WebKit
import Foundation

class ViewController: UIViewController, WKNavigationDelegate, UISearchBarDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var ActInd: UIActivityIndicatorView!

    var userAgentVar: String = "mobile" //User agent
    let credits: String = "zeqe golomb, finbarr o'connell, jackson yan, julian wright" //Credits
    var searchEngine: String = "https://duckduckgo.com/" //Search engine initialization
    var components = URLComponents(string: "https://duckduckgo.com/") //search engine
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() { //Setup stuff
        super.viewDidLoad()
        
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
        
        Code().work()
    }

    func socialMedia(urlString: String) {
        let url = URL(string: urlString)

        let request = URLRequest(url: url!)
        print(request.url?.absoluteString as Any)

        webView?.load(request)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
         webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/5.2 Mobile/15E148 Expedition/604.1"
         ActInd?.startAnimating()
         
     }
     
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         
        ActInd?.stopAnimating()
        searchBar.text = webView.url?.absoluteString
        if (UserDefaults.standard.bool(forKey: "save_history")) {
            let historyElementToAdd = HistoryElement(context: PersistenceService.context)
            historyElementToAdd.url = searchBar.text
            historyElementToAdd.title = webView.title
            PersistenceService.saveContext()
            HistoryTableViewController().historyArray.append(historyElementToAdd)
            HistoryTableViewController().tableView.reloadData()
        }
     }
     
     func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         
         ActInd?.stopAnimating()
         
     }
    
    func verifyUrl (urlString: String?) -> Bool { //tests for url
        let url: URL?
        if (urlString!.contains(" ")){
            return false
        } else if urlString!.hasPrefix("http://") {
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
    
    func openUrl(urlString: String) {
        if (verifyUrl(urlString: searchBar.text!)) {
            
            var url = URL(string: searchBar.text!)
            if (searchBar.text!.starts(with: "http://") || searchBar.text!.starts(with: "https://")) {
                print(searchBar.text!)
            } else {
                url = URL(string: "http://\(searchBar.text!)")
            }
            
            searchBar.text = url?.absoluteString;
            
            let request = URLRequest(url: url!)
            
            webView?.load(request)
        }
        else {
            let queryItemQuery = URLQueryItem(name: "q", value: searchBar.text!);
            
            components?.queryItems = [queryItemQuery]
            
            let request = URLRequest(url: (components?.url)!)
            
            var urlForHistory = request // <- will be used once we get a array working
            
            print(userAgentVar)
            
            webView?.load(request)
        }
    }
    
    
    func searchText(urlString: String) -> URLRequest { //creates the url for a query using duckduckgo
        let queryItemQuery = URLQueryItem(name: "q", value: urlString);
        
        components?.queryItems = [queryItemQuery]
        
        let request = URLRequest(url: (components?.url)!)
        
        return request
    }
    


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //turns the users input into something that the search engine can use
        
        searchBar.resignFirstResponder()
        
        searchBar.text = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        searchBar.text = searchBar.text!.lowercased()
        
        openUrl(urlString: searchBar.text!)
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
            if let components = components {
                components.host
                components.query
                components.percentEncodedQuery

                if let queryItems = components.queryItems {
                    for queryItem in queryItems {
                        if queryItem.name == "url" {
                            openUrl(urlString: queryItem.value!)
                        }
                    }
                }
            }

            
    //        let alertController = UIAlertController(title: "Incoming Message", message: message, preferredStyle: .alert)
    //            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    //        alertController.addAction(okAction)
    //
    //        window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            return true
    }

    @IBAction func reloadSwipe(_ sender: Any) {
   
        webView.reload()
    
    }

    @IBAction func desktopSiteSwipe(_ sender: Any) {
        if userAgentVar == "mobile" {
            webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/5.2 Expedition/605.1.15"
        let userAgentVar: String = "desktop"
            print(userAgentVar)
            webView.reload()
        }
        
        if userAgentVar == "desktop" {
            webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/5.2 Mobile/15E148 Expedition/604.1"
               let userAgentVar: String = "mobile"
                   print(userAgentVar)
            webView.reload()
        }
   
    
    }

// webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil) What's this for?
 
}


