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
    var title: String
    var creationDate: Date
    var tint: String
    var tasks: [Task] = []
 
    
    init(id: UUID = .init(), title: String, creationDate: Date = .init(),  tint: String) {
        self.id = id
        self.title = title
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
