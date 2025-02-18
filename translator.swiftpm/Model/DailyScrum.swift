/*
 See LICENSE folder for this sample’s licensing information.
 */

import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var lengthInMinutes: Int
    var priority: Priority
    var deadline: Date
    var description: String
    var question:[String] =  ["Advantages","Felling","Disadvantages"]
    var attendees: [Attendee]
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, lengthInMinutes: Int, theme: Theme, priority: Priority, deadline: Date, description: String) {
        self.id = id
        self.title = title
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
        self.priority = priority
        self.deadline = deadline
        self.description = description
        self.attendees = question.map {Attendee(name: $0)}
        print("DAILY SCUM: \(attendees.count)")
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", lengthInMinutes: 5, theme: .sky, priority: .daily, deadline: Date.now, description: "")
    }
}

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Study",
                   lengthInMinutes: 10,
                   theme: .yellow,
                   priority: .daily, deadline: Date.now,description: "Come to class"),
        DailyScrum(title: "Code",
                   lengthInMinutes: 5,
                   theme: .orange,
                   priority: .daily, deadline: Date.now,description: "Coding Swift"),
        DailyScrum(title: "Eat",
                   lengthInMinutes: 5,
                   theme: .poppy,
                   priority: .essential, deadline: Date.now,description: "Eating")
    ]
}
