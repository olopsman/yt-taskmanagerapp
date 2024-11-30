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
        Home()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
