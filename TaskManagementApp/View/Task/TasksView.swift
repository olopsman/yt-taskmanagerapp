//
//  TasksView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 29/11/2024.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @Binding var currentDate : Date
    //MARK: Swift Dynamic Query
    @Query private var tasks: [Task]
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Task> {
//            return Calendar.current.isDate($0.creationDate, inSameDayAs: currentDate.wrappedValue)
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate && $0.routine == nil
        }
        //Sorting
        let sortDescriptor = [
            SortDescriptor(\Task.creationDate, order: .reverse)
        ]
        
        self._tasks = Query(filter: predicate,sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        //MARK: Task View
            VStack(alignment: .leading, spacing: 35) {
                ForEach(tasks) { task in
                    TaskRowView(task: task)
                        .background(alignment: .leading) {
                            if tasks.last?.id != task.id {
                                Rectangle()
                                    .frame(width: 1)
                                    .offset(x: 20, y:15)
                                    .padding(.bottom, -15)
                            }
                        }
                }
            }
            .padding([.vertical, .leading], 15)
            .padding(.top, 15)
            .overlay {
                if tasks.isEmpty {
                    Text("No agenda yet for this day")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding([.top])
                        .frame(width: 250)
                }
            }
    }
}

#Preview {
    ContentView()
}
