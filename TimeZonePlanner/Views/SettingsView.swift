//
//  SettingsView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("colorScheme") var colorScheme = true
    @EnvironmentObject var model:TimeModel
    var body: some View {
        VStack {
            Toggle(isOn: $colorScheme) {
                if colorScheme == true {
                    Text("Switch to dark mode")
                } else {
                    Text("Switch to light mode")
                }
                
            }
            DatePicker("Start worktime", selection: $model.startWork, displayedComponents: .hourAndMinute)
            DatePicker("Finish worktime", selection: $model.finishWork, displayedComponents: .hourAndMinute)
            
            Button {
                model.settingsViewIsPresented = false
            } label: {
                Text("Back")
            }

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(TimeModel())
    }
}
