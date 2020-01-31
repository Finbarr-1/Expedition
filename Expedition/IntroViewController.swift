//
//  IntroViewController.swift
//  Expedition
//
//  Created by Julian Wright on 1/19/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var gifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("LOADED INTRO VIEW CONTROLLER")
        
        
        if traitCollection.userInterfaceStyle == .light {
            gifView.loadGif(name: "LightIntro")
        } else {
            gifView.loadGif(name: "DarkIntro")
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.switchToSearchView), userInfo: nil, repeats: false)
    }
    
    @objc func switchToSearchView() {
        performSegue(withIdentifier: "showSearchView", sender: self)
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
