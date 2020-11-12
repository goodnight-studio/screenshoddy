//
//  NSImage+png.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 11/11/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
}

extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}

extension NSImage {
    var png: Data? { tiffRepresentation?.bitmap?.png }
}
