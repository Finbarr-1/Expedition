//
//  AppIconService.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 12/15/19.
//  Copyright © 2019 Zeqe Golomb. All rights reserved.
//

import UIKit

class AppIconService {
    
    let application = UIApplication.shared
    
    enum AppIcon: String {
        case primaryAppIcon
        case DarkAppIcon
        
    }
    
    func changeAppIcon(to appIcon: AppIcon){
    
        application.setAlternateIconName(appIcon.rawValue)
           
    }
}
