//
//  PreviewSampleData.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import Foundation
import SwiftData

@MainActor let previewContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: TaskToDo.self, configurations: config)
        
        if try modelContainer.mainContext.fetch(FetchDescriptor<TaskToDo>()).isEmpty {
            SampleTasks.content.forEach { modelContainer.mainContext.insert($0) }
        }
        
        TaskToDo.deletePreviousTasksToDo(modelContainer: modelContainer)
        
        modelContainer.mainContext.undoManager = UndoManager()
        
        return modelContainer
    } catch {
        fatalError("Failed to create the previewContainer")
    }
}()
