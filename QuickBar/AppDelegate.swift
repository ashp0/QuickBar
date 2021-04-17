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
        // Insert code here to initialize your application
        window.showWindow(nil)

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func applicationDidResignActive(_ notification: Notification) {
        window.close()
    }

}


