//
//  AppDelegate.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let screenshotWC = ScreenshotWindowController()
    
    var preferencesWC: PreferencesWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        screenshotWC.loadWindow()
        screenshotWC.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    @IBAction func showMainWindow(_ sender: Any) {
        screenshotWC.showWindow(self)
    }
    
    @IBAction func showPreferencesWindow(_ sender: Any) {
        
        if preferencesWC == nil {
            preferencesWC = PreferencesWindowController()
        }
        
        preferencesWC?.loadWindow()
        preferencesWC?.showWindow(self)
    }
}

