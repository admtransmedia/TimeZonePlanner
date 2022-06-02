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

    @State var plannerIndex = 0
    
    var body: some View {
       
        VStack {
            if planner.planners.count != plannerIndex {
           Text("\(plannerIndex)")
                Text("\(planner.planners.count)")
          TextField("", text: $planner.planners[plannerIndex].name)
        
            

        
        }
        }
    }
        
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView().environmentObject(TimeModel())
    }
}
