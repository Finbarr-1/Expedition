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
    let credits: String = "Zeqe Golomb, Finbarr O'Connell, Jackson Yan, Julian Wright, Brendan Burkhart, Kai Morita-McVey" //Credits
    var searchEngine: String = "https://duckduckgo.com/" //Search engine initialization
    var components = URLComponents(string: "https://duckduckgo.com/") //search engine
    
    @IBOutlet weak var historySwitch: UISwitch!
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
         
         ActInd?.startAnimating()
         
     }
     
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         
        ActInd?.stopAnimating()
        searchBar.text = webView.url?.absoluteString
        
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
            
                        
            webView?.load(request)
        }
        
    }

    @IBAction func igButton(_ sender: Any) {
        
        dismiss(animated: true) {
            self.socialMedia(urlString: "https://www.instagram.com/themorningcompanymedia/")
        }
        
        // socialMedia(urlString: "https://www.instagram.com/themorningcompanymedia/")
    
        if let url = URL(string: "https://www.instagram.com/themorningcompanymedia/") {
            webView?.load(URLRequest(url: url))
            // UIApplication.shared.open(url)
        }
        
    }

    @IBAction func ytButton(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
            
        let url = URL(string: "https://www.youtube.com/channel/UCizXzjlzl6NksCf6wPLakKw")

        let request = URLRequest(url: url!)

        webView?.load(request)
    
    }
    
    @IBAction func reloadSwipe(_ sender: Any) {
   
        webView.reload()
    
    }

    
    
}

// webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil) What's this for?

