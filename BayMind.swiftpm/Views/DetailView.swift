import SwiftUI

struct DetailView: View {
    @Binding var task: DailyTask
    @State private var editingTask = DailyTask.emptyTask

    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Task Info")) {
                NavigationLink(destination: MeetingView(task: $task)) {
                    Label("Done", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .onDisappear(perform: {
                            if !task.history.isEmpty {
                                task.isDone = true;
                                print("Here")
                            }
                            
                            
                        })
                }
                HStack {
                    Label("Deadline: ", systemImage: "calendar.badge.exclamationmark")
                    Spacer()
                    Text(task.deadline, format: .dateTime)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Priority: ", systemImage: "\(task.priority.displayImage)")
                    Spacer()
                    Text(task.priority.name)
                }
                .accessibilityElement(children: .combine)

                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(task.theme.name)
                        .padding(4)
                        .foregroundColor(task.theme.accentColor)
                        .background(task.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("diagnostic")) {
                if task.history.isEmpty {
                    Label("You need to click done", systemImage: "cursorarrow.click.badge.clock")
                }
                ForEach(task.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
            Section(header: Text("Notes")) {
                if task.description.isEmpty {
                    Label("Try again", systemImage: "calendar.badge.exclamationmark")
                }else{
                    HStack{
                        Text(task.description)
                    }

                }
            }
        }
        .navigationTitle(task.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingTask = task
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(task: $editingTask)
                    .navigationTitle(task.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                task = editingTask
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(task: .constant(DailyTask.sampleData[0]))
        }
    }
}
