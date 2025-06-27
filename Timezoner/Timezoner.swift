//
//  TimezonerApp.swift
//  Timezoner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import SwiftUI

@main struct Timezoner: App {
    //Request permissions for Calendar
    private var request = Permissions()
    var body: some Scene {
        WindowGroup {
            ListView().environmentObject(TimeModel())
                .environmentObject(PlannerModel())
                
        }
    }
}
