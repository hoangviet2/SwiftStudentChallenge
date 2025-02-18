//
//  File.swift
//  translator
//
//  Created by Viet Hoang on 15/2/25.
//

import SwiftUI

enum Priority: String, CaseIterable, Identifiable, Codable {

    case low
    case medium
    case high
    
    var accentColor: Color {
        switch self {
        case .low, .medium: return .black
        case .high: return .white
        }
    }
    
    var displayImage: String{
        switch self{
        case .low: return "exclamationmark"
        case .medium: return "exclamationmark.2"
        case .high: return "exclamationmark.3"
        }
    }
    

    
    var mainColor: Color {
        switch self{
        case .low: return Color("yellow")
        case .medium: return Color("orange")
        case .high: return Color("red")
        }

    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
