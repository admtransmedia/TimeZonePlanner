//
//  ListView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import SwiftUI
struct ListView: View {
	@EnvironmentObject var model:TimeModel
	@EnvironmentObject var planner:PlannerModel
	var body: some View {
		NavigationView {
			List {
				//Check if there is at leat one planner
				if planner.planners.count > 0 {
					// Loopp through all planners
					ForEach (0..<planner.planners.count, id:\.self) {
						index in
						NavigationLink {
							//Go to the particular planner
							PlannerView(plannerIndex: index)
						} label: {
							VStack {
								Text("\(planner.planners[index].name)")
							}
						}
						//Swipe to delete
						.swipeActions(edge: .trailing, allowsFullSwipe: false) {
							Button (role: .destructive) {
								planner.planners.remove(at: index)
								planner.savePlanners()
							} label: {
								Image(systemName: "delete.left")
							}
						}
					}
				}
			}
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .bottomBar) {
					//Settings button
					Button {
						model.settingsViewIsPresented  = true
					} label: {
						Image(systemName: "gear")
					}
				}
				//Add new Planner button, create new planner in the array and and open Planner view
				ToolbarItem(placement: .navigationBarTrailing) {
					NavigationLink {
						PlannerView(plannerIndex: planner.planners.count ).onAppear {
							planner.generateNewPlanner()
						}
					} label: {
						Image(systemName: "plus")
					}
				}
				//Button to show map of all timezones
				ToolbarItem(placement: .bottomBar) {
					NavigationLink {
						ZonesMap()
					} label: {
						Image(systemName: "map")
					}
				}
				ToolbarItem(placement: .principal) {
					Text("My Lists")
						.font(.title)
						.bold()
				}
			}
			//Sheet with settings
			.sheet(isPresented: $model.settingsViewIsPresented ) {
				SettingsView()}
		}
		.navigationViewStyle(.stack)
	}
}
