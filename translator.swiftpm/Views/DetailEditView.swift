/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("To-do information")) {
                TextField("Title", text: $scrum.title)
//                HStack {
//                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
//                        Text("Length")
//                    }
//                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
//                    
//                    Spacer()
//                    Text("\(scrum.lengthInMinutes) minutes")
//                        .accessibilityHidden(true)
//                }
                //TextField("Description", text: $scrum.description, axis: .vertical)
                PriorityPicker(selection: $scrum.priority)
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Description")) {
                TextField("Description", text: $scrum.description, axis: .vertical)
            }
            Section(header: Text("Deadline")) {
                DatePicker("Deadline",
                           selection: $scrum.deadline,
                           in: Date()...,
                           displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                        .accessibilityValue("\(scrum.deadline)")
                Text("\(scrum.deadline)")
                    .accessibilityHidden(true)
            }
//            Section(header: Text("Attendees")) {
//                ForEach(scrum.attendees) { attendee in
//                    Text(attendee.name)
//                }
//                .onDelete { indices in
//                    scrum.attendees.remove(atOffsets: indices)
//                }
//                HStack {
//                    TextField("New Attendee", text: $newAttendeeName)
//                    Button(action: {
//                        withAnimation {
//                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
//                            scrum.attendees.append(attendee)
//                            newAttendeeName = ""
//                        }
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .accessibilityLabel("Add attendee")
//                    }
//                    .disabled(newAttendeeName.isEmpty)
//                }
//            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
