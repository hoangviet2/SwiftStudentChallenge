/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var editingScrum = DailyScrum.emptyScrum

    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Task Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Done", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .onDisappear(perform: {
                            if !scrum.history.isEmpty {
                                scrum.isDone = true;
                                print("Here")
                            }
                            
                            
                        })
                }
                HStack {
                    Label("Deadline: ", systemImage: "calendar.badge.exclamationmark")
                    Spacer()
                    Text(scrum.deadline, format: .dateTime)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Priority: ", systemImage: "\(scrum.priority.displayImage)")
                    Spacer()
                    //Text(scrum.deadline, format: .dateTime.day().month().year())
                    Text(scrum.priority.name)
                }
                .accessibilityElement(children: .combine)

                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("diagnostic")) {
                if scrum.history.isEmpty {
                    Label("You need to click done", systemImage: "cursorarrow.click.badge.clock")
                }else{
                    NavigationLink(destination: HistoryView(history: scrum.history[0])) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(scrum.history[0].date, style: .date)
                        }
                    }
                    
                }
                //                ForEach(scrum.history) { history in
                //                    NavigationLink(destination: HistoryView(history: history)) {
                //                        HStack {
                //                            Image(systemName: "calendar")
                //                            Text(history.date, style: .date)
                //                        }
                //                    }
                //                }
            }
            Section(header: Text("Description")) {
                if scrum.description.isEmpty {
                    Label("Try again", systemImage: "calendar.badge.exclamationmark")
                }else{
                    HStack{
                        Text(scrum.description)
                    }

                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingScrum = scrum
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                scrum = editingScrum
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
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
