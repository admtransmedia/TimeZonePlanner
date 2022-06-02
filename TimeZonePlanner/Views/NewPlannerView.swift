//
//  NewPlannerView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import SwiftUI

struct NewPlannerView: View {
    
    @EnvironmentObject var model:TimeModel
    
    var body: some View {
        VStack {
         
        }
    }
}

struct NewPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlannerView().environmentObject(TimeModel())
    }
}
