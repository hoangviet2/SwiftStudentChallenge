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
    var question:[String] =  ["feeling"]
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
    
    init(id: UUID = UUID(), title: String, lengthInMinutes: Int = 1, theme: Theme, priority: Priority, deadline: Date, description: String) {
        self.id = id
        self.title = title
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
        self.priority = priority
        self.deadline = deadline
        self.description = description
        self.attendees = question.map {Attendee(name: $0)}
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
        DailyScrum(title: "", lengthInMinutes: 1, theme: .sky, priority: .low, deadline: Date.now, description: "")
    }
}

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Study",
                   lengthInMinutes: 1,
                   theme: .yellow,
                   priority: .low, deadline: Date.now,description: "Come to class"),
        DailyScrum(title: "Code",
                   lengthInMinutes: 1,
                   theme: .orange,
                   priority: .medium, deadline: Date.now,description: "Coding Swift"),
        DailyScrum(title: "Eat",
                   lengthInMinutes: 1,
                   theme: .poppy,
                   priority: .high, deadline: Date.now,description: "Eating")
    ]
}
