//
//  PreferencesWindowController.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/4/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

fileprivate extension Selector {
    static let didClickToolbarItem = #selector(PreferencesWindowController.didClickToolbarItem(_:))
}

class PreferencesWindowController: NSWindowController {

    let toolbar = NSToolbar(identifier: NSToolbar.Identifier("PreferencesToolbar"))
    var preferencesWindow: PreferencesWindow?
    
    let toolbarPreferences: [NSToolbarItem.Identifier] = [
        .generalPreferences,
        .accountPreferences,
    ]
    
    let viewControllers: [NSToolbarItem.Identifier: NSViewController] = [
        .generalPreferences: GeneralPreferencesViewController(),
        .accountPreferences: AccountPreferencesViewController(),
    ]
    
    override func loadWindow() {
        
        let offsetX = round(Globals.screenVisibleFrame.width / 2) - round(PreferencesWindow.defaultWidth / 2)
        let offsetY = round(Globals.screenVisibleFrame.height / 2) - round(PreferencesWindow.defaultHeight / 2)
        
        preferencesWindow = PreferencesWindow(
            contentRect: NSRect(x: offsetX, y: offsetY, width: PreferencesWindow.defaultWidth, height: PreferencesWindow.defaultHeight),
            styleMask: [.resizable, .closable, .miniaturizable, .titled ], backing: .buffered, defer: false)
        
        window = preferencesWindow!
        
        toolbar.delegate = self
        toolbar.autosavesConfiguration = false
        toolbar.autosavesConfiguration = false
        toolbar.allowsUserCustomization = false
        toolbar.displayMode = .iconAndLabel
        toolbar.selectedItemIdentifier = .generalPreferences
        
        window?.showsToolbarButton = false
        window?.toolbar = toolbar
        window?.contentViewController = viewControllers[.generalPreferences]
        window?.center()
    }
    
    @objc func didClickToolbarItem(_ sender: NSToolbarItem) {
        
        window?.contentViewController = viewControllers[sender.itemIdentifier]
    }

}

extension PreferencesWindowController: NSToolbarDelegate {
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.action = .didClickToolbarItem
        toolbarItem.target = self
        toolbarItem.paletteLabel = toolbarItem.label
        
        if itemIdentifier == .generalPreferences {
            
            toolbarItem.label = "General"
            toolbarItem.image = NSImage(named: NSImage.preferencesGeneralName)
        }
        
        if itemIdentifier == .accountPreferences {
            
            toolbarItem.label = "Accounts"
            toolbarItem.image = NSImage(named: NSImage.userAccountsName)
        }
     
        return toolbarItem
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarPreferences
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarPreferences
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarPreferences
    }
}
