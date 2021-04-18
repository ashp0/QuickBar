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
        window?.styleMask = [.borderless]
        
       
        self.contentViewController = CollectionViewController(nibName: "CollectionViewController", bundle: nil)
    }
}
