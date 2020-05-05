//
//  NSToolbarItem.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/4/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

extension NSToolbarItem.Identifier {
    
    static var generalPreferences: NSToolbarItem.Identifier {
        return NSToolbarItem.Identifier(rawValue: "General")
    }
    
    static var accountPreferences: NSToolbarItem.Identifier {
        return NSToolbarItem.Identifier(rawValue: "Account")
    }
}
