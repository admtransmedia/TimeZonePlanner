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
