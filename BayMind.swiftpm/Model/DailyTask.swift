//
//  SentimentAnalysis.swift
//  BayMind
//
//  Created by Viet Hoang on 5/2/25.
//
import Foundation

struct DailyTask: Identifiable, Codable {
    let id: UUID
    var title: String
    var lengthInMinutes: Int
    var priority: Priority
    var deadline: Date
    var isDone : Bool = false
    var description: String
    var question:[String] =  ["feeling"]
    var questionlist: [Question]
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
        self.questionlist = question.map {Question(name: $0)}
    }
}

extension DailyTask {
    struct Question: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyTask: DailyTask {
        DailyTask(title: "", lengthInMinutes: 1, theme: .sky, priority: .low, deadline: Date.now, description: "")
    }
}

extension DailyTask {
    static let sampleData: [DailyTask] =
    [
        DailyTask(title: "Study",
                   lengthInMinutes: 1,
                   theme: .yellow,
                   priority: .low, deadline: Date.now,description: "Come to class"),
        DailyTask(title: "Code",
                   lengthInMinutes: 1,
                   theme: .orange,
                   priority: .medium, deadline: Date.now,description: "Coding Swift"),
        DailyTask(title: "Eat",
                   lengthInMinutes: 1,
                   theme: .poppy,
                   priority: .high, deadline: Date.now,description: "Eating")
    ]
}
