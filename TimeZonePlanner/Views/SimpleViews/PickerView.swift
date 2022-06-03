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
    @State var plannerIndex:Int
    
    
    var body: some View {
        VStack {
            Picker("Select timezone", selection: $model.selectedTimeZone) {
                ForEach(model.zones) {
                    zone in

                    Text("\(zone.cityOrCountry ?? "") , \(zone.region ?? "") , \(zone.gmt ?? "")").tag("\(zone.identifier!)")
                }
                
                
            }.pickerStyle(.wheel)
            Button {
                planner.planners[plannerIndex].cities.append(model.selectedTimeZone)
                planner.savePlanners()
              
                model.newCityView = false
            } label: {
                Text("Select")
            }
            

    }
    }
}


