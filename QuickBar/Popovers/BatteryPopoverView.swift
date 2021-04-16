//
//  BatteryPopoverView.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-15.
//

import Cocoa

class BatteryPopoverView: NSViewController {

    @IBOutlet weak var timeToFull: NSTextField!
    
    @IBOutlet weak var timeToEmpty: NSTextField!
    
    @IBOutlet weak var cycleCount: NSTextField!
    @IBOutlet weak var designedCycleCount: NSTextField!
    @IBOutlet weak var manufacturer: NSTextField!
    @IBOutlet weak var manufacturerDate: NSTextField!
    @IBOutlet weak var currentCapacity: NSTextField!
    @IBOutlet weak var maxCapacity: NSTextField!
    @IBOutlet weak var designCapacity: NSTextField!
    @IBOutlet weak var acPowered: NSTextField!
    @IBOutlet weak var isCharging: NSTextField!
    @IBOutlet weak var isCharged: NSTextField!
    @IBOutlet weak var amperage: NSTextField!
    @IBOutlet weak var voltage: NSTextField!
    @IBOutlet weak var watts: NSTextField!
    @IBOutlet weak var temparature: NSTextField!
    @IBOutlet weak var charge: NSTextField!
    @IBOutlet weak var health: NSTextField!
    @IBOutlet weak var timeLeft: NSTextField!
    @IBOutlet weak var timeRemaining: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        getParrams()
    }
    func getParrams() {
        let internalFinder = InternalFinder()
        if let internalBattery = internalFinder.getInternalBattery() {
            timeToFull.stringValue = "\(Int(internalBattery.timeToFull!))"
            timeToEmpty.stringValue = "\(Int(internalBattery.timeToEmpty!))"
            manufacturer.stringValue = internalBattery.manufacturer!
            
            
            
            manufacturerDate.stringValue = "---"
            currentCapacity.stringValue = "\(Int(internalBattery.currentCapacity!))"
            maxCapacity.stringValue = "\(Int(internalBattery.maxCapacity!))"
            designCapacity.stringValue = "\(Int(internalBattery.designCapacity!))"
            
            acPowered.stringValue = "\(internalBattery.acPowered!)"
            isCharging.stringValue = "\(internalBattery.isCharging!)"
            isCharged.stringValue = "\(internalBattery.isCharged!)"
            amperage.stringValue = "\(Int(internalBattery.amperage!))"
            voltage.stringValue = "\(Int(internalBattery.voltage!))"
            watts.stringValue = "\(Int(internalBattery.watts!))"
            temparature.stringValue = "\(Int(internalBattery.temperature!))ºC"
            charge.stringValue = "\(Int(internalBattery.charge!))%"
            health.stringValue = "\(Int(internalBattery.health!))%"
            timeLeft.stringValue = "\(internalBattery.timeLeft)"
            timeRemaining.stringValue = "\(Int(internalBattery.timeRemaining!))"
            cycleCount.stringValue = "\(Int(internalBattery.cycleCount!))"
            designedCycleCount.stringValue = "\(Int(internalBattery.designCycleCount!))"


        }
    }
}
extension Date {
  func asString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
}
