//
//  RoutineListView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 03/12/2024.
//

import SwiftUI
import SwiftData

struct RoutineHomeView: View {
    @State private var currentDate: Date = .init()
    @State private var createNewRoutine: Bool = false
    //MARK: Swift Dynamic Query
    @Query private var routines: [Routine]
    @State private var routineToEdit: Routine?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.vertical) {
                VStack {
                    //Routine View
                    VStack(alignment: .leading, spacing: 35) {
                        ForEach(routines) { routine in
                            RoutineRowView(routine: routine)
                                .onTapGesture {
                                    routineToEdit = routine
                                }
                                .background(alignment: .leading) {
                                    if routines.last?.id != routine.id {
                                        Rectangle()
                                            .frame(width: 1)
                                            .offset(x: 8)
                                            .padding(.bottom, -35)
                                    }
                                }
                        }
                    }
                    .padding([.vertical, .leading], 15)
                    .padding(.top, 15)
                    .overlay {
                        if routines.isEmpty {
                            Text("No routines found")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .frame(width: 150)
                        }
                    }
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
        .sheet(item: $routineToEdit) { routine in
            RoutineEditMainView(routine: routine)
                .presentationDetents([.large])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
        }
        
        .sheet(isPresented: $createNewRoutine, content: {
            RoutineCreationTabView()
                .presentationDetents([.large])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
               
        })
    }
}

#Preview {
    ContentView()
}
