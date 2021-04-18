//
//  CollectionViewItem.swift
//  Lesson 68
//
//  Created by Lucas Derraugh on 10/10/19.
//  Copyright © 2019 Lucas Derraugh. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {
    
    var isFave = false
    static let reuseIdentifier = NSUserInterfaceItemIdentifier("CollectionViewItemReuseIdentifier")
    @IBOutlet weak var appIcon: NSButton!
    weak var delegate: CollectionViewController?

    @IBOutlet weak var mainButton: HoverButton!
    var appssss = [AppItem]()

    @IBAction func appIconClicked(_ sender: NSButton) {
        if isFave == false {
        let apps = favourites.RunItems
        let config = NSWorkspace.OpenConfiguration()
            NSWorkspace.shared.openApplication(at: apps[mainButton.tag].path, configuration: config, completionHandler: nil)
        } else {
            let config = NSWorkspace.OpenConfiguration()

            NSWorkspace.shared.openApplication(at: appssss[mainButton.tag].path, configuration: config, completionHandler: nil)

        }
        /*
        
         */
    }
    override func rightMouseDown(with event: NSEvent) {
        let menu = NSMenu()
//        menu.addItem(withTitle: "Quit", action: #selector(rightClickMenuQuit), keyEquivalent: "qcmd")
        let menuItem = NSMenuItem(title: "Quit QuickBar", action: #selector(rightClickMenuHide), keyEquivalent: "hcmd")
        let menuItem2 = NSMenuItem(title: "Add To Favourites", action: #selector(rightClickMenuFav), keyEquivalent: "fcmd")
        let menuItem3 = NSMenuItem(title: "Remove From Favourites", action: #selector(rightClickMenuUnFav), keyEquivalent: "Fcmd")

        //

        menuItem.target = self
        menuItem2.target = self
        menuItem3.target = self

//        validateMenuItem(menuItem: menuItem)
        menu.addItem(menuItem)
        menu.addItem(menuItem2)
        menu.addItem(menuItem3)

        let p = NSPoint(x: mainButton.frame.origin.x, y: mainButton.frame.origin.y)
       
        menu.popUp(positioning: nil, at: p, in: mainButton)
        
    }

    @objc func rightClickMenuHide() {
        // Hide the application
        exit(0)
    }
    let apps = favourites.RunItems
    var newArray = [AppItem]()

    @objc func rightClickMenuFav() {
        print("Added1")
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            print("Added1")
            if var loadedPerson = try? decoder.decode([AppItem].self, from: savedPerson) {
                print("Added2")
                print("Added3")
                newArray = loadedPerson
                print("Added4")
                newArray.append(AppItem(name: apps[mainButton.tag].name, icon:apps[mainButton.tag].icon, path: apps[mainButton.tag].path))
                print("Added5")
                favourites.RunItems.remove(at: mainButton.tag)
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newArray) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "SavedPerson")
            }
            }
            print("Added")
        }
        collectionView?.reloadData()
        let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
        let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = [path]
        task.launch()
        exit(0)
    }
    @objc func rightClickMenuUnFav() {
        print("Added1")
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            print("Added1")
            if var loadedPerson = try? decoder.decode([AppItem].self, from: savedPerson) {
                print("Added2")
                print("Added3")
                newArray = loadedPerson
                print("Added4")
                print(mainButton.tag)
                favourites.RunItems.append(AppItem(name: loadedPerson[mainButton.tag].name, icon:loadedPerson[mainButton.tag].icon, path: loadedPerson[mainButton.tag].path))
                print("Added5")
                newArray.remove(at: mainButton.tag)
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newArray) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "SavedPerson")
            }
            }
            print(isFullScreen())
            print("Added")
        }
        
        collectionView?.reloadData()
        let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
        let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = [path]
        task.launch()
        exit(0)
    }
    func isFullScreen() -> Bool
    {
        guard let windows = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) else {
            return false
        }

        for window in windows as NSArray
        {
            guard let winInfo = window as? NSDictionary else { continue }
            
            if winInfo["kCGWindowOwnerName"] as? String == "Dock",
               winInfo["kCGWindowName"] as? String == "Fullscreen Backdrop"
            {
                return true
            }
        }
        
        return false
    }
    override func viewDidLoad() {
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode([AppItem].self, from: savedPerson) {
               appssss = loadedPerson
            }
        }
    }
    
}
extension NSCollectionView {
    func indexPathForView(view: AnyObject) -> NSIndexPath? {
//        let originInCollectioView = self.convertPoint(CGPointZero, fromView: (view as! NSView))
        let originInCollectioView = convert(CGPoint.zero, to: (view as! NSView))
        return self.indexPathForItem(at: originInCollectioView) as NSIndexPath?
    }
}
