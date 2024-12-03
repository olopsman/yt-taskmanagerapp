//
//  RoutinesView.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 03/12/2024.
//

import SwiftUI
import SwiftData

struct RoutinesView: View {
    @Binding var currentDate : Date
    //MARK: Swift Dynamic Query
    @Query private var routines: [Routine]
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Routine> {
//            return Calendar.current.isDate($0.creationDate, inSameDayAs: currentDate.wrappedValue)
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        //Sorting
        let sortDescriptor = [
            SortDescriptor(\Routine.creationDate, order: .reverse)
        ]
        
        self._routines = Query(filter: predicate,sort: sortDescriptor, animation: .snappy)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            ForEach(routines) { routine in
                RoutineRowView(routine: routine)
                    .background(alignment: .leading) {
                        if routines.last?.id != routine.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 8)
                                .padding(.bottom, -35)
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
        .overlay {
            if routines.isEmpty {
                Text("No tasks found")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 150)
            }
        }
    }
}

#Preview {
    ContentView()
}
