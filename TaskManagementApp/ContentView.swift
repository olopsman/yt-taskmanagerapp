//
//  ContentView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 26/11/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: Task manager properties
    
    var body: some View {
        TabView {
            TaskHomeView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .preferredColorScheme(.light)
                .tabItem {
                    Label("Tasks", systemImage: "timer")
                }
            .tag(0)
            RoutineHomeView()
                .tabItem {
                    Label("Routines", systemImage: "gear")
                }.tag(1)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }.tag(2)
        }
    }
}

#Preview {
    ContentView()
}
