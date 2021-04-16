//
//  TerminalPopover.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-15.
//

import Cocoa
import AppleScriptObjC
class TerminalPopover: NSViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBOutlet weak var sayProgress: NSProgressIndicator!
    @IBOutlet var outPutField: NSTextView!
    @IBAction func run(_ sender: NSTextField) {
        let terminalScript = sender.stringValue
        if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.Terminal") {
            let configuration = NSWorkspace.OpenConfiguration()
            let doScriptEvent = NSAppleEventDescriptor(eventClass: kAECoreSuite,
                eventID: kAEDoScript, targetDescriptor: nil, returnID: AEReturnID(kAutoGenerateReturnID),
                transactionID: AETransactionID(kAnyTransactionID))
            doScriptEvent.setParam(NSAppleEventDescriptor(string: terminalScript), forKeyword:keyDirectObject)
            configuration.appleEvent = doScriptEvent
            NSWorkspace.shared.openApplication(at: url, configuration: configuration, completionHandler: { app, error in
                if error != nil {
                    print("Error: \(String(describing: error))")
                }
            })
        }

}
}
