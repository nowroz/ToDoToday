//
//  TaskToDo.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import Foundation
import SwiftData

/// A Task to Perform Today.
@Model class TaskToDo {
    /// The title of the task.
    var title: String
    /// The estimated time to perform the task today.
    @Attribute(.unique) var time: Date
    /// Description of the task.
    var taskDetails: String
    /// The flag to toggle for displaying or hiding the description of a task.
    @Attribute(.ephemeral) var shouldShowDetails: Bool = false
    
    init(title: String = "", time: Date = .now, taskDetails: String = "") {
        self.title = title
        self.time = time
        self.taskDetails = taskDetails
    }
}

extension TaskToDo {
    /// Delete the ``TaskToDo`` instances that dates before today.
    ///
    /// The method first fetches all the ``TaskToDo`` instances from the `modelContainer`. Then using the `DateComponents` from today's date it checks for any ``TaskToDo`` instances which dates before today and deletes it:
    ///  ``` swift
    ///  for task in tasksToDo {
    ///  ...
    ///  ...
    ///     if taskYear != todayYear || taskMonth != todayMonth || taskDay != todayDay {
    ///         modelContext.delete(task)
    ///     }
    ///  }
    ///  ```
    ///
    /// - Parameter modelContainer: The modelContainer that contains the to-be-deleted instances of ``TaskToDo``.
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
