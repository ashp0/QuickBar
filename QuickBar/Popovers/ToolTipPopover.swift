//
//  ToolTipPopover.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-15.
//

import Cocoa

class ToolTipPopover: NSViewController {
var appName = "Safari"
    
    @IBOutlet weak var appNameLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        appNameLabel.stringValue = appName
    }
    
}
