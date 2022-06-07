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
    //Default names when user create a custom City
    @State var userCityname = "New city"
    @State var userCityId = "GMT"
    //Index of a particular planner, is being passed from PlannerView
    @State var plannerIndex:Int
    var body: some View {
        TabView{
            // Tab to pick new city up from database
            NavigationView {
                List {
                    //Looping through all time zones after filtering
                    ForEach(model.filteredZones) {
                        zone in
                        Button {
                            //Add new City
                            let selectedTimeZone = City()
                            selectedTimeZone.cityId = zone.identifier!
                            selectedTimeZone.cityName = zone.cityOrCountry!
                            planner.planners[plannerIndex].cities.append(selectedTimeZone)
                            //Save an array of planners
                            planner.savePlanners()
                            //Disable Picker view
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
            //Tab to pick new city up from custom list of time zones
            NavigationView {
                VStack (alignment: .center, spacing: 30) {
                    TextField("", text: $userCityname)
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
                    //Save button
                    Button {
                        //Add new City
                        let selectedTimeZone = City()
                        selectedTimeZone.cityId = userCityId
                        selectedTimeZone.cityName = userCityname
                        planner.planners[plannerIndex].cities.append(selectedTimeZone)
                        //Save an array of planners
                        planner.savePlanners()
                        //Disable Picker view
                        model.newCityView = false
                    } label: {
                        Text("Confirm")
                            .font(.headline)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke( lineWidth: 1)
                            )
                    }
                }
            }
            .tabItem {
                Label("Manual", systemImage: "keyboard")
            }
        }
    }
}
