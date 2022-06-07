//
//  SettingsView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 02.06.2022.
//

import SwiftUI

struct SettingsView: View {
    //Settings, to chose start work time and end forktime
    @EnvironmentObject var model:TimeModel
    var body: some View {
        VStack {
            DatePicker("Start worktime", selection: $model.startWork, displayedComponents: .hourAndMinute)
                .padding()
            DatePicker("Finish worktime", selection: $model.finishWork, displayedComponents: .hourAndMinute)
                .padding()
            Button {
                //Save choosen time and close settings
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
