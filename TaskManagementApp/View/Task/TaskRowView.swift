//
//  TaskViewRow.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 28/11/2024.
//

import SwiftUI

struct TaskRowView: View {
    @Bindable var task: Task
    @Environment(\.modelContext) private var context
    var body: some View {
        HStack(alignment: .top, spacing: 10) {

            Text(task.creationDate.format("hh:mm a"))
                .font(.caption)
                .foregroundStyle(.black)
            VStackLayout(alignment: .leading, spacing: 8) {
                Text(task.taskTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    
               
            }
            .padding(15)
            .hSpacing(.leading)
            .background(task.tintColor, in: .rect(cornerRadius: 10))
            .strikethrough(task.isCompleted, pattern: .solid, color: .gray)
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Task", role: .destructive) {
                    //MARK: Deleting task
                    context.delete(task)
                    try? context.save()
                }
            }
            .offset(y: -8)
                        Circle()
                            .fill(indicatorColor)
                            .frame(width: 10, height: 10)
                            .padding(4)
                            .background(.white.shadow(.drop(color: .black.opacity(0.3), radius: 3)), in: .circle)
                        //make button visible and tapable
                            .overlay {
                                Circle()
                                    .foregroundStyle(.clear)
                                    .contentShape(.circle)
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            task.isCompleted.toggle()
                                        }
                                    }
                            }.padding(.horizontal)
        }
        .hSpacing(.leading)
    }
    
    var indicatorColor: Color {
        if task.isCompleted {
            return .green
        }
        
        return task.creationDate.isSameHour ? .darkBlue : (task.creationDate.isPast ? .red : .black)
    }
}

#Preview {
    ContentView()
}
