//
//  Routine.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 03/12/2024.
//
import SwiftUI
import SwiftData

@Model
class Routine: Identifiable {
    var id: UUID
    var routineTitle: String
    var creationDate: Date
    var tint: String
 
    
    init(id: UUID = .init(), routineTitle: String, creationDate: Date = .init(),  tint: String) {
        self.id = id
        self.routineTitle = routineTitle
        self.creationDate = creationDate
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
        case "TaskColor1": return .taskColor1
        case "TaskColor2": return .taskColor2
        default: return .black

        }
    }
}


//extension Date {
//    static func updateHour(_ value: Int) -> Date {
//        let calendar = Calendar.current
//        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
//    }
//}
