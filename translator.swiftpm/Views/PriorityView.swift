//
//  PriorityView.swift
//  translator
//
//  Created by Viet Hoang on 15/2/25.
//

import SwiftUI

import SwiftUI

struct PriorityView: View {
    let priority: Priority
    
    var body: some View {
        
        Text(priority.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(priority.mainColor)
            .foregroundColor(priority.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct PriorityView_Preview: PreviewProvider {
    static var previews: some View {
        PriorityView(priority: .high)
    }
}
