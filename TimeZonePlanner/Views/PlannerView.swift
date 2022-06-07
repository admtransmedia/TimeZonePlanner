//
//  PlannerView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI
import EventKitUI
import EventKit

struct PlannerView: View {
    @EnvironmentObject var model:TimeModel
    @EnvironmentObject var planner:PlannerModel
    @AppStorage("colorScheme") var colorScheme = true
    @State var plannerIndex:Int
    @State var nameFieldDisables = true
    @State var removeIndex = -1
    @State var calendPrez = false


    
    var body: some View {
        VStack{
        List {
                    if  plannerIndex < planner.planners.count {
                    ForEach (0..<planner.planners[plannerIndex].cities.count, id:\.self) {
                        index in
                     
                           
                        ZStack (alignment: .leading) {

                            Rectangle()
                             // .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(height: 110)
   
                            HStack {


                                VStack (alignment: .leading){
                                    Text("\(planner.planners[plannerIndex].cities[index].cityName.components(separatedBy: "/").last!.replacingOccurrences(of: "_", with: " "))")
                                        .font(.system(size: 30))
                                        .bold()
                                    HStack {
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
                                        Text("\(TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)?.abbreviation() ?? "")")
                                            .font(.headline)
                                    }
             
                           
                                    
                                }
                                .padding(.leading, 5)
                               
                                VStack (alignment: .leading, spacing: 30){
                                    DatePicker("", selection: $model.date, displayedComponents: .hourAndMinute).environment(\.timeZone, TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!)
                                        .transformEffect(.init(scaleX: 1.7, y: 1.7))
                                        .fixedSize().frame(maxWidth: .infinity, alignment: .center)
                                        //TO DO
                                    
                                        DatePicker("      ", selection: $model.date, displayedComponents: .date).environment(\.timeZone, TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!)
                                            .transformEffect(.init(scaleX: 1.1, y: 1.1))
                                            .fixedSize().frame(maxWidth: .infinity, alignment: .center)
                                      
                                    
                                }
                                Spacer()
                                VStack{
                                    Button {
                                        calendPrez = true
                                    } label: {
                                        Image(systemName: "bell")
                                    }
                                }
                                .padding(.leading, 20)
                                
                               
//                                .foregroundColor(.white)
                                



                            }
                            .padding(.horizontal, 5)
                            .background(
                                ((Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).hour! * 60) +
                                     Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).minute!)
                                    >= ((Calendar.current.component(.hour, from: model.startWork) * 60) + Calendar.current.component(.minute, from: model.startWork))
                                        && ((Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).hour! * 60) +
                                            Calendar.current.dateComponents(in: TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!, from: model.date).minute!)
                                    <= ((Calendar.current.component(.hour, from: model.finishWork) * 60) + Calendar.current.component(.minute, from: model.finishWork)) ?
                                (Image("background")
                             .resizable()
                             .opacity(0.9)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(height: 110)
                                .grayscale(0)) : (Image("background")
                                 .resizable()
                                 .opacity(0.9)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .frame(height: 110)
                                    .grayscale(1))
                            )

                        }
                          .padding(.bottom, 5)
                           // .padding(.horizontal)
                          .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                              Button (role: .destructive) {
                                  planner.planners[plannerIndex].cities.remove(at: index)
                                 planner.savePlanners()
                                planner.updateView += 1


                              } label: {
                                  Image(systemName: "delete.left")
                                      
                              }
                              
                             
                              }
                          
                          
                            
                         
                            
                        
                        
                        
                        
                        
                        
                           
                    
                }
                    .listRowSeparator(.hidden)
                    .buttonStyle(PlainButtonStyle())
                    
                   
                }
            
            
        }
        .listStyle(PlainListStyle())
            
                              
            
            
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
       // .padding(.horizontal)
        //list
       // .listRowSeparator(.hidden)
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                if  plannerIndex < planner.planners.count {
                    HStack{
                        if nameFieldDisables == true {
                        TextField("", text: $planner.planners[plannerIndex].name)
                        .disabled(true)
                        .multilineTextAlignment(.center)
                        .font(.title.bold())
                        
                        } else {
                            TextField("", text: $planner.planners[plannerIndex].name,onCommit: {
                                planner.savePlanners()
                                nameFieldDisables = true
                            })
                            .disabled(false)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        
                        Button {
                            nameFieldDisables = false
                            
               
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                        }
                        Button {
                            model.date = Date.now
                        } label: {
                            Image(systemName: "clock.arrow.2.circlepath")
                        }
                        Button {
                            model.filteredZones = model.zones
                            model.newCityView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        

                    }
                }
            }
            

            
        }
        .sheet(isPresented: $model.newCityView ) {
            PickerView(plannerIndex: plannerIndex)
        }
        .sheet(isPresented: $model.newCustom) {
            CustomZone(plannerIndex: plannerIndex)
        }
        .sheet(isPresented: $calendPrez) {
            AddCalendarView()
        }
    }
}

