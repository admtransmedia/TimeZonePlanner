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
    @State var nameFieldDisables = true
    @State var removeIndex = -1
    var body: some View {
        ScrollView {
                    if  plannerIndex < planner.planners.count {
                    ForEach (0..<planner.planners[plannerIndex].cities.count, id:\.self) {
                        index in
                     
                           
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
                                    planner.planners[plannerIndex].cities.remove(at: index)
                                    planner.savePlanners()
                                    planner.updateView += 1


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
            HStack{
                                Button {
                                    model.filteredZones = model.zones
                                    model.newCityView = true
                                } label: {
                                    Text("Add new city")
                                }
            
            
            Button {
               
                model.newCustom = true
            } label: {
                Text("Add custom")
            }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if  plannerIndex < planner.planners.count {
                    HStack{
                        TextField("", text: $planner.planners[plannerIndex].name,onCommit: {
                            planner.savePlanners()
                            nameFieldDisables = true
                        })
                        .disabled(nameFieldDisables)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        
                        Button {
                            nameFieldDisables = false
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                        }
                    }
                }
            }
//            ToolbarItem(placement: .bottomBar) {
//                Button {
//                    model.filteredZones = model.zones
//                    model.newCityView = true
//                } label: {
//                    Text("Add new city")
//                }
//
//            }
            
        }
        .sheet(isPresented: $model.newCityView ) {
            PickerView(plannerIndex: plannerIndex)
        }
        .sheet(isPresented: $model.newCustom) {
            CustomZone(plannerIndex: plannerIndex)
        }
    }
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView( plannerIndex: 0).environmentObject(TimeModel())
    }
}
