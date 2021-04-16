//
//  DockWindowController.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-14.
//

import Cocoa

class DockWindowController: NSWindowController {
    convenience init() {
        self.init(windowNibName: "DockWindowController")
    }
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = NSWindow.Level(rawValue: kCGMainMenuWindowLevel.hashValue - 1)
        window!.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window!.level = .floating
        self.contentViewController = CollectionViewController(nibName: "CollectionViewController", bundle: nil)
    }
    
}
class Button: NSButton {
        var cursor = NSCursor()
       override func resetCursorRects() {
           
           super.resetCursorRects()
           addCursorRect(bounds, cursor: .pointingHand)
       }
   }
