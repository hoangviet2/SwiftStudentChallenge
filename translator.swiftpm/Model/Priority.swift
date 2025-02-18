//
//  File.swift
//  translator
//
//  Created by Viet Hoang on 15/2/25.
//

import SwiftUI

enum Priority: String, CaseIterable, Identifiable, Codable {

    case essential
    case normal
    case daily
    
    var accentColor: Color {
        switch self {
        case .normal, .essential: return .black
        case .daily: return .white
        }
    }
    
    var displayImage: String{
        switch self{
        case .normal: return "exclamationmark"
        case .daily: return "exclamationmark.2"
        case .essential: return "exclamationmark.3"
        }
    }
    

    
    var mainColor: Color {
        switch self{
        case .normal: return Color("yellow")
        case .daily: return Color("orange")
        case .essential: return Color("red")
        }

    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
