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
					NavigationLink {
						PlannerView(plannerIndex: planner.planners.count ).onAppear {
						planner.generateNewPlanner()
						}
					} label: {
						Text("Add new planner")
					}
					if planner.planners.count != 0 {
					ForEach (0..<planner.planners.count, id:\.self) {
                        index in
					NavigationLink {
						
						PlannerView(plannerIndex: index)
						
					} label: {
					
						PlannerString(index:index)

						
					}
                    }

					}
				}
				.navigationTitle("Menu")
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button {
							model.settingsViewIsPresented  = true
						} label: {
							Image(systemName: "gear")
							Text("Settings")
						}
					}
				}
				.sheet(isPresented: $model.settingsViewIsPresented ) {
					SettingsView()}
            }
			

    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(TimeModel())
    }
}
