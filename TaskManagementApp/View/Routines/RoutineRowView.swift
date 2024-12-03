//
//  RoutineRowView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 03/12/2024.
//

import SwiftUI

struct RoutineRowView: View {
    @Bindable var routine: Routine
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(.green)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.3), radius: 3)), in: .circle)
            
            VStackLayout(alignment: .leading, spacing: 8) {
                Text(routine.routineTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    
                Label(routine.creationDate.format("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.black)
            }
            .padding(15)
            .hSpacing(.leading)
            .background(routine.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Task", role: .destructive) {
                    //MARK: Deleting task
//                    context.delete(task)
//                    try? context.save()
                }
            }
            .offset(y: -8)
        }.hSpacing(.leading)
    }
}

#Preview {
    ContentView()
}
