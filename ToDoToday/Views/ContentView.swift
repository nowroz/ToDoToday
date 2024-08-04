//
//  ContentView.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \TaskToDo.time) private var tasksToDo: [TaskToDo]
    
    @State private var showingAddTaskToDoView: Bool = false
    
    var body: some View {
        NavigationStack {
            TasksToDoListViw(tasksToDo: tasksToDo)
                .navigationTitle("ToDoToday")
                .sheet(isPresented: $showingAddTaskToDoView) {
                    AddTaskToDoView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Task", systemImage: "plus") {
                            showingAddTaskToDoView = true
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Undo", systemImage: "arrow.uturn.backward") {
                            modelContext.undoManager?.undo()
                        }
                        .disabled(modelContext.undoManager?.canUndo == false)
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Redo", systemImage: "arrow.uturn.forward") {
                            modelContext.undoManager?.redo()
                        }
                        .disabled(modelContext.undoManager?.canRedo == false)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

