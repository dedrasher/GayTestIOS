//
//  GayTestApp.swift
//  GayTest
//
//  Created by Serega on 29.06.2021.
//

import SwiftUI

@main
struct GayTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
           TestsView()
        }
    }
}
