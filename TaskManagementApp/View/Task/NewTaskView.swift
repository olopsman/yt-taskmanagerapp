//
//  NewTaskView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 28/11/2024.
//

import SwiftUI
import SwiftData

struct NewTaskView: View {
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    //MARK: Model context for saving data
    @Environment(\.modelContext) private var context
    @State private var taskTitle: String = ""
    @State private var taskColor: String = "TaskColor1"
    @State private var segmentControl = SegmentControlType.tasks
    @Binding var taskDate: Date
    @State private var taskDuration: Int = 15
    @State private var taskTime: Date = .init()
    @State private var date = Date()
    @State private var time = Date()

    private let segmentControlTypes = SegmentControlType.allCases
    @Query private var routines: [Routine]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack{
                        Text("When")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        DatePicker("",selection: $taskDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .scaleEffect(0.9, anchor: .leading)
                            
                    }

                }
                
                DatePicker("",selection: $date, displayedComponents: .date)
                                .datePickerStyle(.compact)
                DatePicker("",selection: $time, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.compact)
                               
                        
                    
               

                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Type")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Picker(selection: $segmentControl, label: Text("Filter")) {
                        ForEach(segmentControlTypes, id:\.self) { segment in
                            Text(segment.rawValue)
                                .tag(segment)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                
                if segmentControl.rawValue == "New Task" {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Task Title")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        TextField("Go for a run!", text: $taskTitle)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 15)
                            .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    }
                    .padding(.top, 5)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How long")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Picker(selection: $taskDuration, label: Text("Filter")) {
                            ForEach(taskDurations, id:\.self) { tsk in
                                    Text("\(tsk)")
                                    .tag(tsk)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Task Color")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            
                            let colors: [String] = (1...2).compactMap { index -> String in
                                return "TaskColor\(index)"
                            }
                            
                            HStack(spacing: 0) {
                                ForEach(colors, id: \.self) { color in
                                    Circle()
                                        .fill(Color(color))
                                        .frame(width: 20, height: 20)
                                        .background {
                                            Circle()
                                                .stroke(lineWidth: 2)
                                                .opacity(taskColor == color ? 1 : 0)
                                        }
                                        .hSpacing(.center)
                                        .contentShape(.rect)
                                        .onTapGesture {
                                            withAnimation(.snappy) {
                                                taskColor = color
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.top, 5)
                        
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        print("save")
                        //MARK: Saving the task
                        let task = Task(taskTitle: taskTitle, creationDate: taskDate, tint: taskColor, duration: Int(taskDuration))
                        do {
                            context.insert(task)
                            try context.save()
                            dismiss()
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }, label: {
                        Text("Create Task")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .textScale(.secondary)
                            .foregroundStyle(.black)
                            .hSpacing(.center)
                            .padding(.vertical, 12)
                            .background(Color(taskColor), in: .rect(cornerRadius: 10))
                    })
                    .disabled(taskTitle == "")
                    .opacity(taskTitle == "" ? 0.5 : 1)
                } else {
                    ForEach(routines) { routine in
                        HStack{
                            Text("\(routine.title)")
                            Spacer()
                            Button(action: {
                                print("add the routine subtasks as part of the current date")
                                let newTasks = routine.tasks.map { task in
                                    Task(id: .init(), taskTitle: task.taskTitle, creationDate: taskDate,
                                         isCompleted: task.isCompleted, tint: task.tint)
                                }
                                
                                for obj in newTasks {
                                    context.insert(obj)
                                }
                                
                                dismiss()
                                
                            }) {
                                Label("Add", systemImage: "plus")
                            }
                        }
                            
                        
                    }
                    Spacer()
                }
                
            }
            .padding(15)
            .navigationTitle(Text("Add Task & Routine"))
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
    NewTaskView(taskDate:  .constant(Date()))
        .vSpacing(.bottom)
}
