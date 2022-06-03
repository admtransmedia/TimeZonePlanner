//
//  PlannerView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct PlannerView: View {
    
    @EnvironmentObject var model:TimeModel
    @EnvironmentObject var planner:PlannerModel
    @AppStorage("colorScheme") var colorScheme = true
    @State var plannerIndex:Int
    
    var body: some View {
        VStack {
            if planner.planners.count != plannerIndex {
                TextField("", text: $planner.planners[plannerIndex].name)
                List {
                    ForEach (planner.planners[plannerIndex].cities, id:\.self) {
                        city in
                        VStack{
                            HStack {
                        Text("\(city)")
                        Text("\(TimeZone(identifier: city)?.abbreviation() ?? "")")
                    }
                            HStack{
                            DatePicker("123", selection: $model.date).environment(\.timeZone, TimeZone(identifier: city)!)
                        }
                    }
                    }
            

                }
                Button {
                    model.filteredZones = model.zones
                    model.newCityView = true
                    
                } label: {
                    Text("Add new city")
                }
                .sheet(isPresented: $model.newCityView ) {
                   
                    PickerView(plannerIndex: plannerIndex)
                }

        }
        }
        
    }
        
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView( plannerIndex: 0).environmentObject(TimeModel())
    }
}
