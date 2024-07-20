//
//  ToDoTodayApp.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import SwiftData
import SwiftUI

@main
struct ToDoTodayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskToDo.self, isUndoEnabled: true)
    }
}
