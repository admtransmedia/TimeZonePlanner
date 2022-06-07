//
//  SettingsView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var model:TimeModel
    var body: some View {
        VStack {
          
            DatePicker("Start worktime", selection: $model.startWork, displayedComponents: .hourAndMinute)
                .padding()
            DatePicker("Finish worktime", selection: $model.finishWork, displayedComponents: .hourAndMinute)
                .padding()
            
            Button {
                model.saveWorktime()
                model.settingsViewIsPresented = false
            } label: {
                Text("Back")
            }
            .font(.headline)
            .padding()
            .overlay(
                   RoundedRectangle(cornerRadius: 16)
                       .stroke( lineWidth: 1)
               )
        


        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(TimeModel())
    }
}
