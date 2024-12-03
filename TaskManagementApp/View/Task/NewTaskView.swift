//
//  NewTaskView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 28/11/2024.
//

import SwiftUI

struct NewTaskView: View {
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    //MARK: Model context for saving data
    @Environment(\.modelContext) private var context
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskColor: String = "TaskColor1"
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Title")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Go for a walk!", text: $taskTitle)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                }
                .padding(.top, 5)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Task Date")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.compact)
                            .scaleEffect(0.9, anchor: .leading)
                    }
                    .padding(.top, 5)
                    //Giving some space for tapping the colors
                    .padding(.trailing, -15)
                    
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
                    let task = Task(taskTitle: taskTitle, creationDate: taskDate, tint: taskColor)
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
                
            }
            .padding(15)
            .navigationTitle(Text("New Task"))
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
    NewTaskView()
        .vSpacing(.bottom)
}
