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

        //

        menuItem.target = self
        menuItem2.target = self

//        validateMenuItem(menuItem: menuItem)
        menu.addItem(menuItem)
        menu.addItem(menuItem2)
        let p = NSPoint(x: mainButton.frame.origin.x, y: mainButton.frame.origin.y - (mainButton.frame.height / 2))
       
        menu.popUp(positioning: nil, at: p, in: mainButton)
        
    }

    @objc func rightClickMenuHide() {
        // Hide the application
        exit(0)
    }
    let apps = favourites.RunItems

    @objc func rightClickMenuFav() {
//        item?.appIcon?.image = apps[indexPath.item].icon
        favourites.FavItems.append(AppItem(name: apps[mainButton.tag].name, icon:apps[mainButton.tag].icon, path: apps[mainButton.tag].path))
        favourites.RunItems.remove(at: mainButton.tag)
        
        collectionView?.reloadData()
        let collectVC = superclass?.superclass() as? CollectionViewController
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            collectVC?.favCollectionView.reloadData()
        }
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(favourites.FavItems), forKey:"favItemFavourites")
//        UserDefaults.standard.set(object: favourites.FavItems, forKey: "favItemFavourites")
//        UserDefaults.standard.setValue(favourites.FavItems, forKey: "favItemFavourites")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favourites.FavItems) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedPerson")
    }
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
