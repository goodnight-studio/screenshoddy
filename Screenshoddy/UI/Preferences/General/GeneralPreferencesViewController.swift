//
//  GeneralPreferenceViewController.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/4/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class GeneralPreferencesViewController: NSViewController {

    let generalPreferencesView = GeneralPreferencesView()
    
    override func loadView() {
        
        view = generalPreferencesView
    }
    
}
