//
//  PreviewSampleData.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import Foundation
import SwiftData

/// Shared modelContainer for previews.
///
/// The mainContext of this container checks for sample instances of ``TaskToDo``. If no instances are found, it is populated with ``SampleTasks/content``.
/// ```swift
/// if try modelContainer.mainContext.fetch(FetchDescriptor<TaskToDo>()).isEmpty {
///     SampleTasks.content.forEach { modelContainer.mainContext.insert($0) }
/// }
/// ```
/// Any instances of ``TaskToDo`` that date before today are deleted.
/// ```swift
/// TaskToDo.deletePreviousTasksToDo(modelContainer: modelContainer)
/// ```
/// Enable undo support by assigning an instance of `UndoManager`:
/// ```swift
/// modelContainer.mainContext.undoManager = UndoManager()
/// ```
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
