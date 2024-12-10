//
//  RoutineEditTabView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 08/12/2024.
//

import SwiftUI

struct RoutineEditMainView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var routine: Routine
    var body: some View {
        NavigationView {
            VStack{
                RoutineEditView(routine: routine)
                    .padding(15)
            }
            .navigationTitle(routine.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .tint(.red)
                    }
                }

            }
        }
    }
}

#Preview {
    RoutineEditMainView(routine: routineSample)
}
