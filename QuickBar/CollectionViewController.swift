//
//  CollectionViewController.swift
//  Lesson 68
//
//  Created by Lucas Derraugh on 10/10/19.
//  Copyright © 2019 Lucas Derraugh. All rights reserved.
//

import Cocoa
import IOKit.ps

class CollectionViewController: NSViewController, NSPopoverDelegate, MyElementObserver {
    var sadfdsfIdex = IndexPath()
    @IBOutlet var runningAppsCollectionView: NSCollectionView!
    let popover = NSPopover()
    let popover2 = NSPopover()
    let popover3 = NSPopover()
    let popover4 = NSPopover()
    let defaults = UserDefaults.standard
    @IBOutlet weak var favCollectionView: NSCollectionView!
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var batteryPercentageLabel: NSTextField!
    @IBOutlet weak var betteryPercentageProgress: NSProgressIndicator!
    func didChangeProperty(element: [AppItem]) {
        favCollectionView.reloadData()
        runningAppsCollectionView.reloadData()
    }
    /*
     var popover: NSPopover?
     var positioningView: NSView?

     @IBAction func showPopover(_ sender: NSButton) {
         positioningView = NSView()
         positioningView?.frame = sender.frame
         view.addSubview(positioningView!, positioned: .below, relativeTo: sender)

         popover = NSPopover()
         // configure popover here

         popover?.show(relativeTo: .zero, of: positioningView!, preferredEdge: .maxX)

         positioningView?.frame = NSMakeRect(0, -200, 10, 10)
     }
     
     */
    var positioningView: NSView?

    @IBAction func trashCan(_ sender: Any) {
       //
    }
    @IBAction func calendarButtonClicked(_ sender: NSButton) {
        positioningView = NSView()
        positioningView?.frame = sender.frame
        view.addSubview(positioningView!, positioned: .below, relativeTo: sender)

        if popover2.isShown == true {
            popover2.performClose(sender)
        } else {
            popover2.contentViewController = MLCalendarView(nibName: "MLCalendarView", bundle: nil)
            popover2.show(relativeTo: sender.bounds, of: positioningView!, preferredEdge: .minY)
            positioningView?.frame = NSMakeRect(0, -200, 10, 10)

            popover2.behavior = .transient
        }
    }
    var asdfasdfsadfasdf = [AppItem]()
    private var monitor: Any?

    func addCloseOnOutsideClick(ignoring ignoringViews: [NSView]? = nil) {
        monitor = NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.leftMouseDown) { (event) -> NSEvent? in
            if !self.view.frame.contains(event.locationInWindow) && self.view.isHidden == false {
                
                // If the click is in any of the specified views to ignore, don't hide
                for ignoreView in ignoringViews ?? [NSView]() {
                    let frameInWindow: NSRect = ignoreView.convert(ignoreView.bounds, to: nil)
                    if frameInWindow.contains(event.locationInWindow) {
                        // Abort if clicking in an ignored view
                        return event
                    }
                }
                
                // Getting here means the click should hide the view
                // Perform your hiding code here
                self.view.isHidden = true
            }
            return event
        }
    }
    lazy var window: NSWindow = self.view.window!
        var mouseLocation: NSPoint { NSEvent.mouseLocation }
        var location: NSPoint { window.mouseLocationOutsideOfEventStream }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSEvent.addGlobalMonitorForEvents(matching: [.mouseMoved]) { [self] _ in
            if self.mouseLocation.x < 1300 && self.mouseLocation.y < 60 {
                        window.makeKeyAndOrderFront(nil)
                let newFrame = CGRect(x: 0, y: 0, width: window.frame.size.width, height: window.frame.size.height)
                     NSAnimationContext.runAnimationGroup({ (context) in
                        context.duration = 0.50

                         window.animator().setFrame(newFrame, display: true, animate: true)
                     }, completionHandler: {
                     })
                    } else {
//
                        let newFrame = CGRect(x: 0, y: -1000, width: window.frame.size.width, height: window.frame.size.height)

                             NSAnimationContext.runAnimationGroup({ (context) in
                                context.duration = 0.75

                                 window.animator().setFrame(newFrame, display: true, animate: true)
                             }, completionHandler: {
                             })
                    }
                }
        
        addCloseOnOutsideClick()
        //Adds transparency to the app
        view.window?.isOpaque = false
        view.window?.alphaValue = 0.98 //you can remove this line but it adds a nice effect to it
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode([AppItem].self, from: savedPerson) {
                asdfasdfsadfasdf = loadedPerson
            }
        }
        let blurView = NSVisualEffectView(frame: view.bounds)
        blurView.blendingMode = .behindWindow
        blurView.material = .fullScreenUI
        blurView.state = .active
        view.window?.contentView?.addSubview(blurView)
      
        let items = [AppItem]()
        if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode([AppItem].self, from: savedPerson) {
//                favourites.FavItems.append(contentsOf: loadedPerson)
            }
        }
        
        popover.delegate = self
        runningAppsCollectionView.register(CollectionViewItem.self, forItemWithIdentifier: CollectionViewItem.reuseIdentifier)
        favCollectionView.register(CollectionViewItem.self, forItemWithIdentifier: CollectionViewItem.reuseIdentifier)
        let apps = NSWorkspace.shared.runningApplications.filter{  $0.activationPolicy == .regular }
      
        runningAppsCollectionView.delegate = self
        runningAppsCollectionView.dataSource = self
        favCollectionView.delegate = self
        favCollectionView.dataSource = self
        let center = NSWorkspace.shared.notificationCenter
        center.addObserver(forName: NSWorkspace.willLaunchApplicationNotification,
                            object: nil, // always NSWorkspace
                            queue: OperationQueue.main) { [self] (notification: Notification) in
                                if let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication {
                                    if let savedPerson = UserDefaults.standard.object(forKey: "SavedPerson") as? Data {
                                        let decoder = JSONDecoder()
                                        if let loadedPerson = try? decoder.decode([AppItem].self, from: savedPerson) {
                                            var name1 = [String]()
                                            var name2 = String()
                                            
                                            for load in loadedPerson {name1.append(load.name)}
                                            
                                            name2 = app.localizedName!
                                            if name1.contains(name2) {
                                                print("found lol")
                                            } else {
                                                print("found lol2")
                                                favourites.RunItems.append(AppItem(name: app.localizedName!, icon: (app.icon?.tiffRepresentation)!, path: app.bundleURL!))
                                                runningAppsCollectionView.reloadData()
                                                favCollectionView.reloadData()
                                            }

                                        }
                                    }
//                                        (collectionView.item(at: 3) as? CollectionViewItem)?.view.layer?.backgroundColor = .black
                                    
//

                                        runningAppsCollectionView.reloadData()
                                        favCollectionView.reloadData()
                                    
                                }
        }
        self.setUp()

        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [self] timer in
            self.setUp()
            favCollectionView.reloadData()
            runningAppsCollectionView.reloadData()
        }
//        let center1 = NSWorkspace.shared.notificationCenter
        center.addObserver(forName: NSWorkspace.didTerminateApplicationNotification,
                            object: nil, // always NSWorkspace
                             queue: OperationQueue.main) { (notification: Notification) in
                                if let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication {
                                    if favourites.RunItems.isEmpty != true {
                                    for n in 0...favourites.RunItems.count-1 {
                                        if favourites.RunItems[n].name == app.localizedName {
                                            print("Found Name")
                                            favourites.RunItems.remove(at: n)
                                            self.runningAppsCollectionView.reloadData()
                                            self.favCollectionView.reloadData()
                                        }
                                    }

                                    
                                    }
                                }
        }
        
//        collectionView.collectionViewLayout = bidirectionalLayout()
    }
    func bundleIdentifier(forAppName appName: String) -> String? {

        let workspace = NSWorkspace.shared
        let appPath = workspace.fullPath(forApplication: appName)
        if let appPath = appPath {
            let appBundle = Bundle(path: appPath)
            return appBundle?.bundleIdentifier
        }
        return nil
    }
    @IBAction func googleSearchButtonClicked(_ sender: NSButton) {
        if popover4.isShown == true {
            popover4.performClose(sender)
        } else {
            popover4.contentViewController = GoogleSearchPopover(nibName: "GoogleSearchPopover", bundle: nil)
           
            popover4.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
            popover4.behavior = .transient
        }
    }
    @IBAction func terminalButtonClick(_ sender: NSButton) {
        if popover3.isShown == true {
            popover3.performClose(sender)
        } else {
            popover3.contentViewController = TerminalPopover(nibName: "TerminalPopover", bundle: nil)
           
            popover3.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
            popover3.behavior = .transient
        }
    }
    
    @IBAction func batteryButtonPressed(_ sender: NSButton) {
        if popover.isShown == true {
            let internalFinder = InternalFinder()

            if let internalBattery = internalFinder.getInternalBattery() {
              
                batteryPercentageLabel.stringValue = "\(Int(internalBattery.charge!))%"
                
                betteryPercentageProgress.doubleValue = internalBattery.charge!
            }

            popover.performClose(sender)
        } else {
        popover.contentViewController = BatteryPopoverView(nibName: "BatteryPopoverView", bundle: nil)
        popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
        popover.behavior = .transient
            batteryPercentageLabel.stringValue = "Close"
        }
    }
    func popoverShouldClose(_ popover: NSPopover) -> Bool {
        setUp()
        return true
    }
}

extension CollectionViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {

//    func numberOfSections(in collectionView: NSCollectionView) -> Int {
//        let apps = NSWorkspace.shared.runningApplications.filter{  $0.activationPolicy == .regular }
//
//        return apps.count
//    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        let apps = favourites.RunItems

        if collectionView == runningAppsCollectionView {
            return apps.count
        }
        else if collectionView == favCollectionView {
            print("Favourite Application Count:")
                    return asdfasdfsadfasdf.count
        }
        return 0
    }
//    var itttem: CollectionViewItem?
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: CollectionViewItem.reuseIdentifier, for: indexPath) as? CollectionViewItem
        switch collectionView {
        case runningAppsCollectionView:
            let apps = favourites.RunItems
            item?.appIcon?.image = NSImage(data: apps[indexPath.item].icon)
            item?.mainButton.tag = indexPath.item
            break
        case favCollectionView:
//            let apps = NSWorkspace.shared.runningApplications.filter{  $0.activationPolicy == .regular }
            item?.isFave = true
            item?.mainButton.isFave = true
            item?.appIcon?.image = NSImage(data: asdfasdfsadfasdf[indexPath.item].icon)
            item?.mainButton.tag = indexPath.item
            break
        default:
            break
        }
       
//        item?.appNameLabel.stringValue = apps[indexPath.item].localizedName!
        
        return item!
    }
    func setUp() {
        let internalFinder = InternalFinder()
        if let internalBattery = internalFinder.getInternalBattery() {
            // Internal battery found, access properties here.
            if internalBattery.charge == 99 {
                batteryPercentageLabel.stringValue = "100%"
                
                betteryPercentageProgress.doubleValue = 100
            } else {
            batteryPercentageLabel.stringValue = "\(Int(internalBattery.charge!))%"
            
            betteryPercentageProgress.doubleValue = internalBattery.charge!
            }
//            let date = Date()
//            let calendar = Calendar.current
//            let hour = calendar.component(.hour, from: date)
//            let minutes = calendar.component(.minute, from: date)
//            let day = calendar.component(.day, from: date)
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy/MM/dd HH:mm"
//            let weekday = calendar.component(, from: date)
            
            let date : Date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "eee dd, H:MM a"
            let todaysDate = dateFormatter.string(from: date)
//            let am = calendar.amSymbol
            dateLabel.stringValue = "\(todaysDate)"
        }

    }
}
extension String {
    func runAsCommand() -> String {
        let pipe = Pipe()
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", String(format:"%@", self)]
        task.standardOutput = pipe
        let file = pipe.fileHandleForReading
        task.launch()
        if let result = NSString(data: file.readDataToEndOfFile(), encoding: String.Encoding.utf8.rawValue) {
            return result as String
        }
        else {
            return "--- Error running command - Unable to initialize string from file data ---"
        }
    }
}
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
public extension UserDefaults {

    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func set<T: Codable>(object: T, forKey: String) throws {

        let jsonData = try JSONEncoder().encode(object)

        set(jsonData, forKey: forKey)
    }

    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {

        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }

        return try JSONDecoder().decode(objectType, from: result)
    }
}
extension UserDefaults {
    func imageForKey(key: String) -> NSImage? {
        var image: NSImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? NSImage
        }
        return image
    }
    func setImage(image: NSImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        set(imageData, forKey: key)
    }
}
func == (lhs: AppItem, rhs: AppItem) -> Bool {
    return lhs.name == rhs.name && lhs.icon == rhs.icon && lhs.path == rhs.path
}
