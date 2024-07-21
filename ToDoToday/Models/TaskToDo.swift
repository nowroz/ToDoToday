//
//  TaskToDo.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import Foundation
import SwiftData

@Model class TaskToDo {
    var title: String
    @Attribute(.unique) var time: Date
    var taskDetails: String
    @Attribute(.ephemeral) var shouldShowDetails: Bool = false
    
    init(title: String = "", time: Date = .now, taskDetails: String = "") {
        self.title = title
        self.time = time
        self.taskDetails = taskDetails
    }
}

extension TaskToDo {
    @MainActor static func deletePreviousTasksToDo(modelContainer: ModelContainer) {
        let mainContext = modelContainer.mainContext
        let descriptor = FetchDescriptor<TaskToDo>()
        guard let tasksToDo = try? mainContext.fetch(descriptor) else {
            fatalError("Failed to fetch models")
        }
        
        let todayDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: .now)
        guard let todayDay = todayDateComponents.day, let todayMonth = todayDateComponents.month, let todayYear = todayDateComponents.year else {
            fatalError("Found one or more nil values in date components for todayDateComponents")
        }
        
        for task in tasksToDo {
            let taskDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: task.time)
            guard let taskDay = taskDateComponents.day, let taskMonth = taskDateComponents.month, let taskYear = taskDateComponents.year else {
                fatalError("Found one or more nil values in date components for taskDateComponents")
            }
            
            if taskYear != todayYear || taskMonth != todayMonth || taskDay != todayDay {
                mainContext.delete(task)
            }
        }
    }
}
