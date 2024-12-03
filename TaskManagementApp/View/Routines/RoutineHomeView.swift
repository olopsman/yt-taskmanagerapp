//
//  RoutineListView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 03/12/2024.
//

import SwiftUI

struct RoutineHomeView: View {
    @State private var currentDate: Date = .init()
    @State private var createNewRoutine: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.vertical) {
                VStack {
                    //Routine View
                    RoutinesView(currentDate: $currentDate)
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }.scrollIndicators(.hidden)
        }
        .vSpacing(.top)
        //MARK: Creating new routine
        .overlay(alignment: .bottomTrailing) {
            Button(action: {
                createNewRoutine.toggle()
            }, label: {
                Image(systemName: "plus")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 55, height: 55, alignment: .center)
                    .background(.darkBlue.shadow(.drop(color: .black.opacity(0.25), radius: 5, x:10, y: 10)), in: .circle)
            })
            .padding(15)
        }
        .sheet(isPresented: $createNewRoutine, content: {
            NewRoutineView()
                .presentationDetents([.height(300)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
               
        })
    }
}

#Preview {
    ContentView()
}
