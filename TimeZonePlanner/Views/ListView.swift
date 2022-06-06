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
					if planner.planners.count > 0 {
					ForEach (0..<planner.planners.count, id:\.self) {
                        index in
					NavigationLink {
						
						PlannerView(plannerIndex: index)
						
					} label: {
					
						VStack {
							Text("\(planner.planners[index].name)")
							
							

							
							
						}
						

						
					}.swipeActions(edge: .trailing, allowsFullSwipe: false) {
						Button {

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
						Button {
							model.settingsViewIsPresented  = true
						} label: {
							Image(systemName: "gear")
							
						}
					}
					ToolbarItem(placement: .bottomBar) {
						
							NavigationLink {
								PlannerView(plannerIndex: planner.planners.count ).onAppear {
								planner.generateNewPlanner()
								}
							
						} label: {
							Image(systemName: "plus")
							
						}
					}
					ToolbarItem(placement: .bottomBar) {
						
							NavigationLink {
								ZonesMap()
							
						} label: {
							Image(systemName: "map")
							
						}
					}
					ToolbarItem(placement: .principal) {
						Text("Menu").font(.title)
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
