//
//  MainView.swift
//  TimeZonePlanner
//
//  Created by Sergei Kriukov on 01.06.2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model:TimeModel

   
    
    var body: some View {
        NavigationView {
         ListView()
                .navigationTitle("Your planners")
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(TimeModel())
    }
}
