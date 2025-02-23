import SwiftUI

struct TaskView: View {
    @Binding var tasks: [DailyTask]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewTaskView = false
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            
            List($tasks.sorted(by: {
                if $0.isDone.wrappedValue == $1.isDone.wrappedValue {
                    return $0.deadline.wrappedValue < $1.deadline.wrappedValue
                }
                return !$0.isDone.wrappedValue && $1.isDone.wrappedValue
            })) { $tasks in
                NavigationLink(destination: DetailView(task: $tasks)) {
                        CardView(task: tasks)
                    }
                    .listRowBackground(tasks.theme.mainColor)
            }
            .navigationTitle("Greeting,")
            .toolbar {
                Button(action: {
                    isPresentingNewTaskView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New to-do")
            }
        }
        .sheet(isPresented: $isPresentingNewTaskView) {
            NewTask(tasks: $tasks, isPresentingNewTaskView: $isPresentingNewTaskView)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(tasks: .constant(DailyTask.sampleData), saveAction: {})
    }
}
