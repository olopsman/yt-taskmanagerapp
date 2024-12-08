//
//  NewRoutineView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 04/12/2024.
//

import SwiftUI

struct RoutineCreationTabView: View {
    @State private var selectedTab = 0
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    //MARK: Model context for saving data
    @Environment(\.modelContext) private var context
    @State private var routine: Routine?
    @State private var routineTitle: String = ""
    @State private var routineDate: Date = .init()
    @State private var routineColor: String = "TaskColor1"
    @State private var tasks: [Task] = []
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                
                NewRoutineFormView()
                    .tag(0)
                    .padding(15)
                //MARK: how to pass the routine
                if routine != nil {
                    RoutineEditView(routine: routine!)
                        .tag(1)
                        .padding(15)
                }
            }
            .navigationTitle((routine == nil) ? "New Routine" : routine!.title)
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
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false
            }
        }
    }
    //MARK: Step 1 to create the routine
    @ViewBuilder
    func NewRoutineFormView() -> some View  {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Routine name")
                    .font(.caption)
                    .foregroundStyle(.gray)

                TextField("My morning routine", text: $routineTitle)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(
                        .white.shadow(
                            .drop(
                                color: .black.opacity(0.25), radius: 2)),
                        in: .rect(cornerRadius: 10))
            }
            .padding(.top, 5)

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Routine Date")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    DatePicker("", selection: $routineDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                }
                .padding(.top, 5)
                //Giving some space for tapping the colors
                .padding(.trailing, -15)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Color")
                        .font(.caption)
                        .foregroundStyle(.gray)

                    let colors: [String] = (1...2).compactMap {
                        index -> String in
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
                                        .opacity(
                                            routineColor == color
                                                ? 1 : 0)
                                }
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        routineColor = color
                                    }
                                }
                        }
                    }
                }
                .padding(.top, 5)
                


            }

            Spacer(minLength: 0)

            Button(
                action: {
                    print("save")
                    //MARK: Saving the routine
                    routine = Routine(
                        title: routineTitle,
                        creationDate: routineDate, tint: routineColor)
                        context.insert(routine!)
                    withAnimation {
                        selectedTab = 1
                        UIScrollView.appearance().isScrollEnabled = true
                    }
                },
                label: {
                    Text("Create")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.black)
                        .hSpacing(.center)
                        .padding(.vertical, 12)
                        .background(
                            Color(routineColor),
                            in: .rect(cornerRadius: 10))
                }
            )
            .disabled(routineTitle == "")
            .opacity(routineTitle == "" ? 0.5 : 1)
        }
    }
}

#Preview {
    RoutineCreationTabView()
}
