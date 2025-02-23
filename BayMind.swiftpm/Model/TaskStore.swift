//
//  SentimentAnalysis.swift
//  TaskStore
//
//  Created by Viet Hoang on 20/2/25.
//
import SwiftUI

@MainActor
class TaskStore: ObservableObject {
    @Published var tasks: [DailyTask] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("tasks.data")
    }
    

    
    func load() async throws {
        let task = Task<[DailyTask], Error> {
            let fileURL = try Self.fileURL()
            print(fileURL)
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let dailyTasks = try JSONDecoder().decode([DailyTask].self, from: data)
            return dailyTasks
        }
        let tasks = try await task.value
        self.tasks = tasks
    }
    
    func save(tasks: [DailyTask]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(tasks)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
