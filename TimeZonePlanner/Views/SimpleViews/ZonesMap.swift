//
//  ZonesMap.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 06.06.2022.
//

import SwiftUI

struct ZonesMap: View {
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Image("zonesmap")
                
        }
        .navigationTitle("World time zones")
    }
}

struct ZonesMap_Previews: PreviewProvider {
    static var previews: some View {
        ZonesMap()
    }
}
