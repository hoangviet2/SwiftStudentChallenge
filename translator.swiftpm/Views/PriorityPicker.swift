//
//  PriorityPicker.swift
//  translator
//
//  Created by Viet Hoang on 15/2/25.
//

import SwiftUI

struct PriorityPicker: View {
    @Binding var selection: Priority
    
    var body: some View {
        Picker("Priority", selection: $selection){
            ForEach(Priority.allCases) { priority in
                PriorityView(priority: priority)
                    .tag(priority)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct PriorityPicker_Preview: PreviewProvider {
    static var previews: some View {
        PriorityPicker(selection: .constant(.low))
    }
}
