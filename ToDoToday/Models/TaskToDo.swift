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
