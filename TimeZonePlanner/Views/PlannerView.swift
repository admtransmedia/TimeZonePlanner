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
    //Index of the particular planner, is being passed from List view
    @State var plannerIndex:Int
    //Is Name of the planner editable
    @State var nameFieldDisables = true
    //Is Calendar view sheet presented
    @State var calendPrez = false
    var body: some View {
        VStack{
            List {
                //Check if there is at least one planner in an array. Without this condition, the view renders faster than the new planner is created and there  is a nil in the loop further
                if  plannerIndex < planner.planners.count {
                    //Loop through all cities
                    ForEach (0..<planner.planners[plannerIndex].cities.count, id:\.self) {
                        index in
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(height: 110)
                            HStack {
                                VStack (alignment: .leading){
                                    //City name
                                    Text("\(planner.planners[plannerIndex].cities[index].cityName.components(separatedBy: "/").last!.replacingOccurrences(of: "_", with: " "))")
                                        .font(.system(size: 30))
                                        .bold()
                                    HStack {
                                        //Check if there is worktime
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
                                        //GMT difference
                                        Text("\(TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)?.abbreviation() ?? "")")
                                            .font(.headline)
                                    }
                                }
                                .padding(.leading, 5)
                                //Date ant time pickers
                                VStack (alignment: .leading, spacing: 30){
                                    DatePicker("", selection: $model.date, displayedComponents: .hourAndMinute).environment(\.timeZone, TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!)
                                        .transformEffect(.init(scaleX: 1.7, y: 1.7))
                                        .fixedSize().frame(maxWidth: .infinity, alignment: .center)
                                    DatePicker("            ", selection: $model.date, displayedComponents: .date).environment(\.timeZone, TimeZone(identifier: planner.planners[plannerIndex].cities[index].cityId)!)
                                        .transformEffect(.init(scaleX: 1.1, y: 1.1))
                                        .fixedSize().frame(maxWidth: .infinity, alignment: .center)
                                }
                                Spacer()
                                VStack{
                                    //Button to add new Calendar event
                                    Button {
                                        calendPrez = true
                                    } label: {
                                        Image(systemName: "bell")
                                    }
                                }
                                .padding(.leading, 20)
                            }
                            .padding(.horizontal, 5)
                            //Background image with condition which image we should show, depends of worktime
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
                        //Swipe actiont to delete planner
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                if  plannerIndex < planner.planners.count {
                    HStack{
                        //Check if city name editable
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
                        //Button to edit city name
                        Button {
                            nameFieldDisables = false
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                        }
                        //Button to set current time in all cities
                        Button {
                            model.date = Date.now
                        } label: {
                            Image(systemName: "clock.arrow.2.circlepath")
                        }
                        //Button to add new city and open Picker view
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
        //Sheet with Picker view (add new city)
        .sheet(isPresented: $model.newCityView ) {
            PickerView(plannerIndex: plannerIndex)
        }
        //Sheet to add new Calendar event
        .sheet(isPresented: $calendPrez) {
            AddCalendarView()
        }
    }
}
