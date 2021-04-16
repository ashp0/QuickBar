//
//  AlphaButtons.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-15.
//

import Cocoa

class AlphaButtons: NSButton {

    override func mouseEntered(with event: NSEvent) {
        self.alphaValue = 1
    }

    override func mouseExited(with event: NSEvent) {
        self.alphaValue = 0.8
    }
    private var trackingArea: NSTrackingArea?

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if let trackingArea = self.trackingArea {
            self.removeTrackingArea(trackingArea)
        }

        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeAlways]
        let trackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
}
