//
//  Dark:Light.swift
//  Expedition
//
//  Created by Finbarr O'Connell on 12/16/19.
//  Copyright © 2019 Zeqe Golomb. All rights reserved.
//

import Foundation


class darkLight {
       
    @IBAction func didTapPrimaryIcon() {  //should change to light icon
        AppIconService().changeAppIcon(to: .primaryAppIcon)

    }
    @IBAction func didTapDarkIcon() { //should change to dark icon
        AppIconService().changeAppIcon(to: .DarkAppIcon)
       
    }
}

func DarkModeToggle(_ sender: Any) { //turns dark mode on and off
    
}
