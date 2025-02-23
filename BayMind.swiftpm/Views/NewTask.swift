import SwiftUI

struct NewTask: View {
    @State private var newTask = DailyTask.emptyTask
    @Binding var tasks: [DailyTask]
    @Binding var isPresentingNewTaskView: Bool
    //@FocusState var isFocusOnDescription: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(task: $newTask)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewTaskView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            tasks.append(newTask)
                            isPresentingNewTaskView = false
                        }
                    }
                }
        }
    }
}

struct NewTaskSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTask(tasks: .constant(DailyTask.sampleData), isPresentingNewTaskView: .constant(true))
    }
}
