//
//  PlannerString.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct PlannerString: View {
    @EnvironmentObject var planner:PlannerModel
    @EnvironmentObject var model:TimeModel
    @State var index:Int
    @State var plannerIndex:Int
    var body: some View {
        ZStack (alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 90)
            
            HStack (spacing: 30) {
                if  ((Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).hour! * 60) +
                     Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).minute!)
                    >= ((Calendar.current.component(.hour, from: model.startWork) * 60) + Calendar.current.component(.minute, from: model.startWork))
                        && ((Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).hour! * 60) +
                            Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).minute!)
                    <= ((Calendar.current.component(.hour, from: model.finishWork) * 60) + Calendar.current.component(.minute, from: model.finishWork))
                {
                    Image(systemName: "sun.max.fill")
                } else {
                    Image(systemName: "moon.stars")
                }
                
                VStack {
                    HStack{
                        Text("\(planner.planners[plannerIndex].cities[index].cityName.components(separatedBy: "/").last!.replacingOccurrences(of: "_", with: "-"))")
                        Text("\(TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)?.abbreviation() ?? "")")
                    }
                    DatePicker("", selection: $model.date).environment(\.timeZone, TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!)
                   
                    
                }
                Button {
                    planner.deleteCity(plannerIndex: plannerIndex, index: index)
//                    planner.planners[plannerIndex].cities.remove(at: index)
//                    planner.savePlanners()
//                    planner.updateView += 1


                } label: {
                    Image(systemName: "delete.left")
                }

                
            }
            .padding()
          
        }
            .padding(.bottom, 5)
            .padding(.horizontal)
    }
}

