//
//  ContentView.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \TaskToDo.time) private var tasksToDo: [TaskToDo]
    
    @State private var showingAddTaskToDoView: Bool = false
    @State private var showingTaskDetails: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasksToDo) { taskToDo in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(taskToDo.title)
                            
                            Spacer()
                            
                            Divider()
                            Text(taskToDo.time, format: .dateTime.hour().minute())
                                .fontDesign(.monospaced)
                        }
                        .font(taskToDo.shouldShowDetails ? .title : nil)
                        
                        if taskToDo.shouldShowDetails {
                            VStack(alignment: .leading){
                                Divider()
                                Text(taskToDo.taskDetails)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding(taskToDo.shouldShowDetails ? 10 : 0)
                    .contentShape(.rect)
                    .onTapGesture {
                        toggleTaskDetails(of: taskToDo)
                    }
                }
            }
            .navigationTitle("ToDoToday")
            .sheet(isPresented: $showingAddTaskToDoView) {
                AddTaskToDoView()
            }
            .toolbar {
                Button("Add Task", systemImage: "plus") {
                    showingAddTaskToDoView = true
                }
            }
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
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

