//
//  CustomZone.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 05.06.2022.
//

import SwiftUI

struct CustomZone: View {
    @EnvironmentObject var model:TimeModel
    @EnvironmentObject var planner:PlannerModel
    //Index of a particular planner
    @State var plannerIndex:Int
    
    @State var userCityname = "New city"
    @State var userCityId = "GMT"
    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $userCityname)
        //        .multilineTextAlignment(.center)
                .font(.title)
                Picker("", selection: $userCityId) {
                    ForEach(model.userZonez) {
                        zone in
                        Text("\(zone.gmt ?? "")").tag("\(zone.identifier!)")
                    }
                    
                }
                Button {
                                            let selectedTimeZone = City()
                                            selectedTimeZone.cityId = userCityId
                                            selectedTimeZone.cityName = userCityname
                                            
                                            planner.planners[plannerIndex].cities.append(selectedTimeZone)
                                            planner.savePlanners()
                    model.newCustom = false
                } label: {
                    Text("Confirm")
                }

            }

    }
}
}
