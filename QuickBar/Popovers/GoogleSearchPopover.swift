//
//  GoogleSearchPopover.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-15.
//

import Cocoa

class GoogleSearchPopover: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchEnterPressed(_ sender: NSSearchField) {
        let originalString = sender.stringValue
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print("Formatted String:")
        print(escapedString!)
        print("\n")
        let url = URL(string:"https://www.google.com/search?client=safari&rls=en&q=\(escapedString!)&ie=UTF-8&oe=UTF-8")
        
//        NSWorkspace.shared.open([url],
//                                withAppBundleIdentifier:"com.apple.Safari",
//                                options: [],
//                                additionalEventParamDescriptor: nil,
//                                launchIdentifiers: nil)
        NSWorkspace.shared.open(url!)
    }
}

