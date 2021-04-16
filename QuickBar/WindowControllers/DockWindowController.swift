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
        let theSelector = #selector(closeWindow)
            let theCenter = NotificationCenter.default
            let theWindow = window
            theCenter.addObserver(self, selector: theSelector, name: NSWindow.didResignKeyNotification, object: theWindow)
            theCenter.addObserver(self, selector: theSelector, name: NSWindow.didResignMainNotification, object: theWindow)
        
        window?.level = NSWindow.Level(rawValue: kCGMainMenuWindowLevel.hashValue - 1)
        window!.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window!.level = .floating
        self.contentViewController = CollectionViewController(nibName: "CollectionViewController", bundle: nil)
//        window?.backgroundColor = .clear
    }
    @objc func closeWindow() {
        window?.close()
    }
}
class Button: NSButton {
        var cursor = NSCursor()
       override func resetCursorRects() {
           
           super.resetCursorRects()
           addCursorRect(bounds, cursor: .pointingHand)
       }
   }
