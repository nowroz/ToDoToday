//
//  Color-Theme.swift
//  ToDoToday
//
//  Created by Nowroz Islam on 20/7/24.
//

import Foundation
import SwiftUI

extension Color {
    /// Background color to display when a task is tapped and the color scheme is light.
    static var listLightBackground: Color {
        Color(red: 0.35, green: 0.6, blue: 0.9)
    }
    
    /// Background color to display when a task is tapped and the color scheme is dark.
    static var listDarkBackground: Color  {
        Color(red: 0.1, green: 0.2, blue: 0.45)
    }
}
