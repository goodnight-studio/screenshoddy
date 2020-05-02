//
//  ScreenshotWindowController.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class ScreenshotWindowController: NSWindowController {
    
    var screenshotWindow: ScreenshotWindow?
    
    override func loadWindow() {
        
        let offsetX = round(Globals.screenVisibleFrame.width / 2) - round(ScreenshotWindow.defaultWidth / 2)
        let offsetY = round(Globals.screenVisibleFrame.height / 2) - round(ScreenshotWindow.defaultHeight / 2)
        
        
        screenshotWindow = ScreenshotWindow(
            contentRect: NSRect(x: offsetX, y: offsetY, width: ScreenshotWindow.defaultWidth, height: ScreenshotWindow.defaultHeight),
            styleMask: [.resizable, .closable, .miniaturizable, .titled ], backing: .buffered, defer: false)
        
        window = screenshotWindow!
        window?.setFrameAutosaveName(screenshotWindow!.frameAutosaveName)
        
    }

}
