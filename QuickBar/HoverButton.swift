//
//  HoverButton.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-15.
//

import Cocoa

class HoverButton: NSButton {

    let popover = NSPopover()
var isFave = false
    var positioningView: NSView?
    override func mouseEntered(with event: NSEvent) {
        if isFave == false {
        let apps = favourites.RunItems
        let viewController = ToolTipPopover(nibName: "ToolTipPopover", bundle: nil)
            viewController.appName = apps[self.tag].name
        popover.contentViewController = viewController
        popover.animates = false
        positioningView = NSView()
            positioningView?.frame = self.frame
           addSubview(positioningView!, positioned: .below, relativeTo: self)
        
        popover.show(relativeTo: self.bounds, of: positioningView!, preferredEdge: .minY)
        positioningView?.frame = NSMakeRect(0, -200, 10, 10)
        } else {
            let apps = favourites.FavItems
            let viewController = ToolTipPopover(nibName: "ToolTipPopover", bundle: nil)
            viewController.appName = apps[self.tag].name
            popover.contentViewController = viewController
            popover.animates = false
            positioningView = NSView()
                positioningView?.frame = self.frame
               addSubview(positioningView!, positioned: .below, relativeTo: self)
            
            popover.show(relativeTo: self.bounds, of: positioningView!, preferredEdge: .minY)
            positioningView?.frame = NSMakeRect(0, -200, 10, 10)
        }
    }

    override func mouseExited(with event: NSEvent) {
        popover.performClose(self)
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
