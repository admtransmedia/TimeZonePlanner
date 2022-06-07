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
    
    
    @State var userCityname = "New city"
    @State var userCityId = "GMT"
    
    //Index of a particular planner
    @State var plannerIndex:Int
    var body: some View {
        TabView{
            
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
            .tabItem {
                        Label("Database", systemImage: "globe")
                    }
            
            NavigationView {
                VStack (alignment: .center, spacing: 30) {
                    TextField("", text: $userCityname)
            //        .multilineTextAlignment(.center)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("", selection: $userCityId) {
                        ForEach(model.userZonez) {
                            zone in
                            Text("\(zone.gmt ?? "")").tag("\(zone.identifier!)")
                        }
                        
                    }
                    .pickerStyle(.wheel)
                    Button {
                                                let selectedTimeZone = City()
                                                selectedTimeZone.cityId = userCityId
                                                selectedTimeZone.cityName = userCityname
                                                
                                                planner.planners[plannerIndex].cities.append(selectedTimeZone)
                                                planner.savePlanners()
                        model.newCityView = false
                    } label: {
                      
                           
                                
                                Text("Confirm")
                            .font(.headline)
                            .padding()
                            .overlay(
                                   RoundedRectangle(cornerRadius: 16)
                                       .stroke(.black, lineWidth: 1)
                               )
                        
                        .foregroundColor(.black)
                        
                    }

                }

        }
            .tabItem {
                Label("Manual", systemImage: "keyboard")
            }
        }
    }
}


