//
//  SampleTasks.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 19/7/24.
//

import Foundation

struct SampleTasks {
    private init() { }
    
    static let content: [TaskToDo] = [
        TaskToDo(title: "Breakfast", time: getTime(hour: 07, minutes: 30), taskDetails: "Early morning breakfast, yum! Egg is always a good choice. Skipping the breakfast is not a good idea."),
        TaskToDo(title: "Laundry", time: getTime(hour: 18, minutes: 30), taskDetails: "Only on Saturday and Tuesday. Not a fan but must do it."),
        TaskToDo(title: "Dinner", time: getTime(hour: 20, minutes: 30), taskDetails: "What should I eat for dinner today?")
    ]
    
    private static func getTime(hour: Int, minutes: Int) -> Date {
        var defaultComponents = Calendar.current.dateComponents([.day, .month, .year], from: .now)
        defaultComponents.hour = hour
        defaultComponents.minute = minutes
        
        guard let date = Calendar.current.date(from: defaultComponents) else {
            fatalError()
        }
        
        return date
    }
}
