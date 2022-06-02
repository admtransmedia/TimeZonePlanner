//
//  PlannerString.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct PlannerString: View {
    @EnvironmentObject var planner:PlannerModel
    @State var index:Int
    var body: some View {
        VStack {
            Text("\(planner.planners[index].name)")
            
            ForEach (planner.planners[index].cities, id:\.self) {
                    city in
                    Text("\(city)")
                }

            
            
        }
    }
}

