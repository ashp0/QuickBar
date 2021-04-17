//
//  favourites.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-16.
//

import Cocoa

struct favourites {
    // The favourite Application List
//    static var FavItems = [AppItem]() {
//        didSet {
//            let observers: [MyElementObserver] = []
//            print("FavItems Array has been modified")
//            for observer in observers {
//                            observer.didChangeProperty(element: self.FavItems)
//            }
//        }
//    }
    // The current running applications
    static var RunItems = [AppItem]() {
        didSet {
            let observers: [MyElementObserver] = []
            print("RunItems Array has been modified")
            for observer in observers {
                observer.didChangeProperty(element: self.RunItems)
            }
        }
    }
}
protocol MyElementObserver {
    func didChangeProperty(element: [AppItem])
}

extension MyElementObserver {
    func didChangeProperty(element: [AppItem]) {}
}
