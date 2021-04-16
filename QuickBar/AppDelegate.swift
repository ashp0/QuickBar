//
//  AppDelegate.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-14.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

   let window = DockWindowController()


    func applicationDidFinishLaunching(_ aNotification: Notification) {

        window.showWindow(nil)
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


