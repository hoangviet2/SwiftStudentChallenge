import SwiftUI

struct DetailEditView: View {
    @Binding var task: DailyTask
    @FocusState var isFocusOnDescription: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .onTapGesture {
                    isFocusOnDescription = false
                }
            
            Form {
                Section(header: Text("Task information")) {
                    TextField("Title", text: $task.title)
                        .focused($isFocusOnDescription)
                    
                    PriorityPicker(selection: $task.priority)
                    ThemePicker(selection: $task.theme)
                }
                Section(header: Text("Notes")) {
                    TextField("Notes", text: $task.description, axis: .vertical)
                        .focused($isFocusOnDescription)
                }
                
                Section(header: Text("Deadline")) {
                    DatePicker("Deadline",
                               selection: $task.deadline,
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
        DetailEditView(task: .constant(DailyTask.sampleData[0]))
    }
}
