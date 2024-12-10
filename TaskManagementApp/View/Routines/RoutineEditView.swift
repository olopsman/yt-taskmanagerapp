//
//  EditRoutineView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 07/12/2024.
//

import SwiftUI

struct RoutineEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var routine: Routine
    @State private var scheduledDate = Date()
    @State private var task: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {            
            VStack(alignment: .leading, spacing: 8) {
                Text("Routine name")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("My morning routine", text: $routine.title)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(
                        .white.shadow(
                            .drop(
                                color: .black.opacity(0.25), radius: 2)),
                        in: .rect(cornerRadius: 10))
            }
            .padding(.top, 5)
            
            
            
            
            
            //MARK: Add subtasks
            VStack(alignment: .leading, spacing: 8) {
                Text("Routine Tasks")
                    .font(.caption)
                    .foregroundStyle(.gray)
                HStack{
                    TextField("Add tasks", text: $task)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(
                            .white.shadow(
                                .drop(
                                    color: .black.opacity(0.25), radius: 2)),
                            in: .rect(cornerRadius: 10))
                    Button(action: {
                        routine.tasks.append(Task(taskTitle: task, tint: "TaskColor1"))
                        task = ""
                        
                    }){
                        Label("", systemImage: "plus")
                    }
                    .disabled(task == "")
                }
                
                
                List{
                    Section{
                        ForEach(routine.tasks) { tsk in
                            NavigationLink(destination: Text("View")){
                                Text("\(tsk.taskTitle)")
                            }
                                
                        }
                    }header: {
                        Text("Tasks")
                    }
                }
                .listStyle(.plain)
                
            }
            
            Spacer(minLength: 0)
            
            Button(
                action: {
                    print("update")
                    //MARK: Update the routine
                    dismiss()
                    
                },
                label: {
                    Text("Continue")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.black)
                        .hSpacing(.center)
                        .padding(.vertical, 12)
                        .background(
                            Color(routine.tintColor),
                            in: .rect(cornerRadius: 10))
                }
            )
            .disabled(routine.title == "")
            .opacity(routine.title == "" ? 0.5 : 1)
            
        }
    }
}

#Preview {
    RoutineEditMainView(routine: routineSample)
}

