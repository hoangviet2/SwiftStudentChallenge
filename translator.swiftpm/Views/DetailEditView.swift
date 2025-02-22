/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyTask
    @FocusState var isFocusOnDescription: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .onTapGesture {
                    isFocusOnDescription = false
                }
            
            Form {
                Section(header: Text("To-do information")) {
                    TextField("Title", text: $scrum.title)
                        .focused($isFocusOnDescription)
                    
                    PriorityPicker(selection: $scrum.priority)
                    ThemePicker(selection: $scrum.theme)
                }
                Section(header: Text("Description")) {
                    TextField("Description", text: $scrum.description, axis: .vertical)
                        .focused($isFocusOnDescription)
                }
                
                Section(header: Text("Deadline")) {
                    DatePicker("Deadline",
                               selection: $scrum.deadline,
                               in: Date()...,
                               displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            isFocusOnDescription = false
                        }
                        
                    }
                }
            }
            .toolbarRole(.automatic)
        }
        
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyTask.sampleData[0]))
    }
}
