//
//  RoutineRowView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 03/12/2024.
//

import SwiftUI

struct RoutineRowView: View {
    @Bindable var routine: Routine
    @Environment(\.modelContext) private var context
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
           
            
            VStackLayout(alignment: .leading, spacing: 8) {
                Text(routine.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                if routine.tasks.count > 0 {
                    Label("\(routine.tasks.count) tasks", systemImage: "clock")
                        .font(.caption)
                        .foregroundStyle(.black)
                }
            }
            .padding(15)
            .hSpacing(.leading)
            .background(routine.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Routine", role: .destructive) {
                    //MARK: Deleting routine
                    context.delete(routine)
                    try? context.save()
                }
            }
            .offset(y: -8)
        }.hSpacing(.leading)
    }
}

#Preview {
    ContentView()
}
