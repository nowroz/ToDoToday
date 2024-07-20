//
//  AddTaskToDoView.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import SwiftData
import SwiftUI

struct AddTaskToDoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var time: Date = .now
    @State private var taskDetails: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    
                    DatePicker("Select time", selection: $time, displayedComponents: .hourAndMinute)
                }
                
                Section("Description") {
                    TextEditor(text: $taskDetails)
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func save() {
        let newTaskToDo = TaskToDo()
        newTaskToDo.title = title
        newTaskToDo.time = time
        newTaskToDo.taskDetails = taskDetails
        
        modelContext.insert(newTaskToDo)
        
        dismiss()
    }
}

#Preview {
    AddTaskToDoView()
        .modelContainer(previewContainer)
}
