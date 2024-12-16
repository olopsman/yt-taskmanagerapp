//
//  Home.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 26/11/2024.
//

import SwiftUI

struct TaskHomeView: View {
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeeekIndex: Int = 1
    @State private var createNewTask: Bool = false
    //MARK: Pagination logic
    @State private var createWeek: Bool = false
    //MARK: Animation namespace
    @Namespace private var animation
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 0) {
                HeaderView()
                
                ScrollView(.vertical) {
                    VStack {
                        //Tasks View
                        TasksView(currentDate: $currentDate)
                    }
                    .hSpacing(.center)
                    .vSpacing(.center)
                }.scrollIndicators(.hidden)
            }
            .vSpacing(.top)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Ideal Day"))
            //TODO: unambigoius use of toolbar
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: {}, label: {
//                        Image(.paulo)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 45, height: 45)
//                            .clipShape(.circle)
//                    })
//                }
//            }
        }
        //MARK: Creating new task
        .overlay(alignment: .bottomTrailing) {
            Button(action: {
                createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 55, height: 55, alignment: .center)
                    .background(.darkBlue.shadow(.drop(color: .black.opacity(0.25), radius: 5, x:10, y: 10)), in: .circle)
            })
            .padding(15)
        }
        .onAppear(perform: {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                //MARK: Pagination logic - fetch last week and next week
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPrevioustWeek())
                }
                
                weekSlider.append(currentWeek)

                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())

                }
            }
        })
        .sheet(isPresented: $createNewTask, content: {
            NewTaskView(taskDate: $currentDate)
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
               
        })
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5){
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.darkBlue)
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)

            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            
            //MARK: Week Slider
            TabView(selection: $currentWeeekIndex) {
                ForEach(weekSlider.indices, id:\.self) { index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
            
        }
        .hSpacing(.leading)
//        .overlay(alignment: .topTrailing, content: {
//            Button(action: {}, label: {
//                Image(.paulo)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 45, height: 45)
//                    .clipShape(.circle)
//            })
//        })
        .padding(15) //used for pagination offset
        .background(.gray.opacity(0.1))
        .onChange(of: currentWeeekIndex, initial: false) { oldValue, newValue in
                //MARK: Pagination logic
                /* create weeks when it reaches the first/last page(index)
                 - to preserve memory we will only have 3 week index, and inserting weeks fetched to an existing index like 0 and removing the last index array.
                 */
            
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
            }
        }
    }
    
    
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .frame(width: 35, height: 35)
                        .background(content: {
                            if isSameDate(day.date, currentDate) {
                                Circle()
                                    .fill(.darkBlue)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            //MARK: Indicator to show which is today's date
                            
                            if day.date.isToday {
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                            
                        })
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)

                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    //MARK: Updating current date
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            //MARK: Pagination logic - what is this?
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                            //MARK: When offset reaches 15 and if the createWeek is true then sipy generate the next set of week - each page in the TabView contains 15 pts of padding, so minX will not end at zero but end at 15
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                         
                    
                    }
            }
        }
    }
    

    
    //MARK: Pagination logic - Generate the week
    func paginateWeek() {
        // Safecheck
        if weekSlider.indices.contains(currentWeeekIndex) {
            if let firstDate = weekSlider[currentWeeekIndex].first?.date, currentWeeekIndex == 0 {
                // Insert new week at 0th index and removing last array item
                weekSlider.insert(firstDate.createPrevioustWeek(), at: 0)
                weekSlider.removeLast()
                currentWeeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeeekIndex].last?.date, currentWeeekIndex == (weekSlider.count - 1) {
                // Append new week at last index and removing first array item
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeeekIndex = weekSlider.count - 2
            }
        }
    }
}

#Preview {
    ContentView()
}
