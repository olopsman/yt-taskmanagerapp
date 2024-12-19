//
//  Date+Extensions.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 26/11/2024.
//

import SwiftUI

//MARK: Date extension need for building UI

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    //MARK: Checking if date is today    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    //MARK: Checking if the date is same hour
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    var isPast: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    //MARK: Fetching week based on given date
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startOfWeek = weekForDate?.start  else {
            return []
        }
        //Iterate to get the full week
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(.init(date: weekDay))
            }
        }
        return week
    }
    
    //MARK: Fetch next and previous week
    
    //MARK: Creating next week based on the last date of the current week
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        //get the start of day for the last date
        let startOfLastDate = calendar.startOfDay(for: self)
        // add one day to the last day
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        //we get the week for that date
        return fetchWeek(nextDate)
    }
    //MARK: Creating previous week based on the start date of the current week
    func createPrevioustWeek() -> [WeekDay] {
        let calendar = Calendar.current
        //get the start of day for the first date
        let startOfFirstDate = calendar.startOfDay(for: self)
        // minus one day to the start day
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else {
            return []
        }
        //we get the week for that date
        return fetchWeek(previousDate)
    }
    
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
    
    func stripTime() -> Date {
       let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
       let date = Calendar.current.date(from: components)
       return date!
   }
}
