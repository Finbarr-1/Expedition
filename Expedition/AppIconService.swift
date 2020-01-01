//
//  AppIconService.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 12/15/19.
//  Copyright © 2019 The Morning Company. All rights reserved.
//

import UIKit

class AppIconService {
    
    let application = UIApplication.shared
    
    enum AppIcon: String {
        case primaryAppIcon
        case darkAppIcon
        
    }
    
    func changeAppIcon(to appIcon: AppIcon){
    
        application.setAlternateIconName(appIcon.rawValue)
           
    }
}
