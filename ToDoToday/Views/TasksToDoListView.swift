//
//  TasksToDoListViw.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 21/7/24.
//

import SwiftData
import SwiftUI

struct TasksToDoListViw: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    var tasksToDo: [TaskToDo]
    
    @State private var showingTaskDetails: Bool = false
    
    var body: some View {
        List {
            if tasksToDo.isEmpty {
                ContentUnavailableView {
                    Label("No Tasks for Today", systemImage: "pencil.and.list.clipboard")
                } description: {
                    Text("Tap the plus button to add tasks.")
                }
            } else {
                ForEach(tasksToDo) { taskToDo in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(taskToDo.title)
                            
                            Spacer()
                            
                            Divider()
                            Text(taskToDo.time, format: .dateTime.hour().minute())
                                .fontDesign(.monospaced)
                        }
                        .font(taskToDo.shouldShowDetails ? .title.weight(.semibold) : nil)
                        
                        if taskToDo.shouldShowDetails {
                            VStack(alignment: .leading){
                                Divider()
                                Text(taskToDo.taskDetails)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.vertical)
                        }
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        toggleTaskDetails(of: taskToDo)
                    }
                    .listRowBackground(taskToDo.shouldShowDetails ? listRowBackground() : nil)
                }
                .onDelete(perform: deleteTasksToDo)
            }
        }
    }
    private func deleteTasksToDo(at offsets: IndexSet) {
        for offset in offsets {
            let taskToDo = tasksToDo[offset]
            modelContext.delete(taskToDo)
        }
    }
    
    private func toggleTaskDetails(of taskToDo: TaskToDo) {
        for currentTaskToDo in tasksToDo {
            if currentTaskToDo === taskToDo {
                withAnimation {
                    currentTaskToDo.shouldShowDetails.toggle()
                }
            } else {
                currentTaskToDo.shouldShowDetails = false
            }
        }
    }
    
    private func listRowBackground() -> Color {
        if colorScheme == .light {
            Color.listLightBackground
        } else {
            Color.listDarkBackground
        }
    }
}

#Preview {
    struct TasksToDoListViewPreview: View {
        @Query private var tasksToDo: [TaskToDo]
        
        var body: some View {
            TasksToDoListViw(tasksToDo: tasksToDo)
        }
    }
    
    return TasksToDoListViewPreview()
        .modelContainer(previewContainer)
}
