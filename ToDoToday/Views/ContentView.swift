//
//  ContentView.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    
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
    
    private func listRowBackground() -> Color {
        if colorScheme == .light {
            Color.listLightBackground
        } else {
            Color.listDarkBackground
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

