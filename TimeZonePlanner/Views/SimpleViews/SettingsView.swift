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
            Text("Working day")
                .font(.headline)
            DatePicker("Start time", selection: $model.startWork, displayedComponents: .hourAndMinute)
                .padding(.horizontal, 50)
            DatePicker("End time", selection: $model.finishWork, displayedComponents: .hourAndMinute)
                .padding(.horizontal, 50)
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
                    .stroke(.blue, lineWidth: 1)
            )
        }
    }
}
