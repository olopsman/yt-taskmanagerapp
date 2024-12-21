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
    var title: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    var routine: Routine?
    var duration: Int
    var timeScheduled: Bool
    
    init(id: UUID = .init(), title: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String, duration: Int = 0, timeScheduled: Bool = false) {
        self.id = id
        self.title = title
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
        self.duration = duration
        self.timeScheduled = timeScheduled
    }
    
    var tintColor: Color {
        switch tint {
        case "TaskColor1": return .taskColor1
        case "TaskColor2": return .taskColor2
        default: return .black

        }
    }
}

var taskSample: Task = Task.init(title: "test", tint: "TaskColor1")

