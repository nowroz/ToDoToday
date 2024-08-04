//
//  ToDoTodayApp.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import SwiftData
import SwiftUI

@main
@MainActor struct ToDoTodayApp: App {
    /// The shared modelContainer for the app.
    ///
    /// Everytime the app launches, ``TaskToDo/deletePreviousTasksToDo(modelContainer:)`` makes sure that  the tasks  that are dated before today are deleted from this modelContainer:
    /// ``` swift
    /// TaskToDo.deletePreviousTasksToDo(modelContainer: modelContainer)
    /// ```
    ///
    /// Enable undo support by assigning `UndoManager`:
    /// ```swift
    /// modelContainer.mainContext.undoManager = UndoManager()
    /// ```
    let modelContainer: ModelContainer = {
        do {
            let modelContainer = try ModelContainer(for: TaskToDo.self)
            
            TaskToDo.deletePreviousTasksToDo(modelContainer: modelContainer)
            
            modelContainer.mainContext.undoManager = UndoManager()
            
            return modelContainer
        } catch {
            fatalError("Failed to create the model container")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
