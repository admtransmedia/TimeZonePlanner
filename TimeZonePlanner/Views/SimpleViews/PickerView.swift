//
//  PickerView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct PickerView: View {
    var newPlanner = Planner()
    @EnvironmentObject var model:TimeModel
    @EnvironmentObject var planner:PlannerModel
    @State var name = "New planner"
    
    var body: some View {
        VStack {
            Picker("Select timezone", selection: $model.selectedTimeZone) {
                ForEach(model.zones) {
                    zone in

                    Text("\(zone.cityOrCountry ?? "") , \(zone.region ?? "") , \(zone.gmt ?? "")").tag("\(zone.identifier!)")
                }.pickerStyle(.wheel)
                
                
            }
            Button {
                print(model.selectedTimeZone)
            } label: {
                Text("Add new City")
            }
            if planner.planners.count == 0 {
            Button {
                print(name)
                    newPlanner.name = name
                newPlanner.cities.append(model.selectedTimeZone)
                planner.planners.append(newPlanner)
                
                
                
               
            } label: {
                Text("Finish")
            }
            }

    }
    }
}


