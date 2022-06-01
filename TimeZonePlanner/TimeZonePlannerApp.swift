//
//  TimeZonePlannerApp.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import SwiftUI

@main
struct TimeZonePlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ListView().environmentObject(TimeMOdel())
        }
    }
}
