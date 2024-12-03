//
//  Task.swift
//  TaskManagementApp
//
//  Created by Paulo Orquillo on 26/11/2024.
//
import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID 
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    var routine: Routine?
    
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
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

//var sampleTasks: [Task] = [
//    .init(taskTitle: "Record Video", creationDate: .updateHour(-5), isCompleted: true, tint: .taskColor1),
//    .init(taskTitle: "Redesign Website", creationDate: .updateHour(-3), tint: .taskColor2),
//    .init(taskTitle: "Go for a walko", creationDate: .updateHour(-4), tint: .taskColor1),
//    .init(taskTitle: "Edit video", creationDate: .updateHour(0), tint: .taskColor1),
//    .init(taskTitle: "Publish video", creationDate: .updateHour(2), tint: .taskColor2)
//
//]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
