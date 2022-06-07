//
//  Permissions.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 06.06.2022.
//

import Foundation
import UIKit
import EventKit
import EventKitUI
class Permissions {
    var eventStore = EKEventStore()
    init () {
        requestAccess()
    }
    func requestAccess() {
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                }
            }
        }
    }
}
