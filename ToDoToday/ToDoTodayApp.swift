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
    let modelContainer: ModelContainer = {
        do {
            let modelContainer = try ModelContainer(for: TaskToDo.self)
            
            TaskToDo.deletePreviousTasksToDo(modelContainer: modelContainer)
            
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
