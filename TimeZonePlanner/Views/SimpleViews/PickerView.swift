//
//  PickerView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct PickerView: View {
    @EnvironmentObject var model:TimeModel
    @EnvironmentObject var planner:PlannerModel
    //Index of a particular planner
    @State var plannerIndex:Int
    var body: some View {
        NavigationView {
            List {
                ForEach(model.filteredZones) {
                    zone in
                    Button {
                        
                        let selectedTimeZone = City()
                        selectedTimeZone.cityId = zone.identifier!
                        selectedTimeZone.cityName = zone.cityOrCountry!
                       
                        planner.planners[plannerIndex].cities.append(selectedTimeZone)
                        planner.savePlanners()
                        model.newCityView = false
                    } label: {
                        Text("\(zone.cityOrCountry?.replacingOccurrences(of: "_", with: " ") ?? "") , \(zone.region ?? "") , \(zone.gmt ?? "")").tag("\(zone.identifier!)").foregroundColor(.black)
                    }
                }
            }
            //Search bar
        }.searchable(text: $model.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: model.searchText) { newValue in
                model.searchZones()
            }
    }
}


