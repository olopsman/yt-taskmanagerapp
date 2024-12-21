//
//  RoutineTaskView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 21/12/2024.
//

import SwiftUI
import SwiftData

struct RoutineTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var task: Task
    @State private var segmentControl = SegmentControlType.tasks
    private let segmentControlTypes = SegmentControlType.allCases
    //MARK: Model context for saving data
    @Environment(\.modelContext) private var context
    @State private var taskDuration: Int = 15

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Title")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Go for a run!", text: $task.title)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                }
                .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("How long")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Picker(selection: $task.duration, label: Text("Filter")) {
                        ForEach(taskDuration, id:\.self) { tsk in
                                Text("\(tsk)")
                                .tag(tsk)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                HStack {
                    Text("Time")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    DatePicker("",selection: $task.time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                        .font(.caption)
                        .foregroundStyle(.gray).isHidden(!task.timeScheduled)
                    Button(action: {
                        task.timeScheduled = true
                    }) {
                        Text("None")
                    }.isHidden(task.timeScheduled, remove: true)
                    
                    
                    Button(action: {
                        task.timeScheduled = false
                    }) {
                        Text("X")
                    }.isHidden(!task.timeScheduled)
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
                                            .opacity(task.color == color ? 1 : 0)
                                    }
                                    .hSpacing(.center)
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            task.color = color
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.top, 5)
                    
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    let calendar = Calendar.current
                    let midnight = calendar.startOfDay(for: task.date)
                    print("save \(midnight)")
                    
                    
                    let timeValue = calendar.component(.hour, from: time)
                    let minValue = calendar.component(.minute, from: time)

                    print(timeValue);
                    print(minValue);
                    
                    //create add the time
                    let dateTime = calendar.date(byAdding: .hour, value: timeValue, to: midnight)!
                    let dateMin = calendar.date(byAdding: .minute, value: minValue, to: dateTime)!
                    

                    

                    
                    //MARK: Saving the task
//                    let task = Task(taskTitle: taskTitle, creationDate: showTimeInput ? dateMin: midnight, tint: taskColor, duration: Int(taskDuration), timeScheduled: showTimeInput)
                    do {
//                        context.insert(task)
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
                        .background(Color(task.color), in: .rect(cornerRadius: 10))
                })
                .disabled(task.title == "")
                .opacity(task.title == "" ? 0.5 : 1)
            
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

#Preview {
    RoutineTaskView(task: taskSample)
}
