//
//  FavouriteItem.swift
//  QuickBar
//
//  Created by Ashwin Paudel on 2021-04-16.
//

import Cocoa

struct AppItem:Codable {
    // The app name
    let name: String
    // The app icon in a data format
    // Cannot put image into a codeable
    let icon: Data
    // The path for the application
    // Used for launching it
    let path: URL
}

