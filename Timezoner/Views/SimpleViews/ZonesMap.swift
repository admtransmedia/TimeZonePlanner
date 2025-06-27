//
//  ZonesMap.swift
//  Timezoner
//
//  Created by Sergei Kriukov on 06.06.2022.
//

import SwiftUI
//Scrollable map of all time zones
struct ZonesMap: View {
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Image("zonesmap")
        }
        .navigationTitle("World time zones")
    }
}
