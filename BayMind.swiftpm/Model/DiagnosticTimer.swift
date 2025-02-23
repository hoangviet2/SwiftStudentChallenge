//
//  SentimentAnalysis.swift
//  Timer
//
//  Created by Viet Hoang on 20/2/25.
//

import Foundation

/// Keeps time for a daily check meeting. Keep track of the total meeting time.

@MainActor
final class DiagnosticTimer: ObservableObject {
    /// A struct to keep track of meeting attendees during a meeting.
    struct Speaker: Identifiable {
        /// The attendee name.
        let name: String
        /// True if the attendee has completed their turn to speak.
        var isCompleted: Bool
        /// Id for Identifiable conformance.
        let id = UUID()
    }
    
    /// The name of the meeting attendee who is speaking.
    @Published var activeSpeaker = ""
    /// The number of seconds since the beginning of the meeting.
    @Published var secondsElapsed = 0
    /// The number of seconds until all attendees have had a turn to speak.
    @Published var secondsRemaining = 0
    /// All meeting attendees, listed in the order they will speak.
    private(set) var speakers: [Speaker] = []

    /// The meeting meeting length.
    private(set) var lengthInMinutes: Int
    /// A closure that is executed when a new attendee begins speaking.
    var speakerChangedAction: (() -> Void)?

    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60)
    }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate: Date?
    
    init(lengthInMinutes: Int = 0, attendees: [DailyTask.Question] = []) {
       self.lengthInMinutes = 1
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
    
    /// Start the timer.
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }
    
    /// Stop the timer.
    func stopTimer() {
        timer?.invalidate()
        timerStopped = true
    }
    
    /// Advance the timer to the next speaker.
    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }

    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        secondsElapsedForSpeaker = 0
        guard index < speakers.count else { return }
        speakerIndex = index
        activeSpeaker = speakerText
        secondsElapsed = secondsPerSpeaker
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
    }

    nonisolated private func update() {

        Task { @MainActor in
            guard let startDate,
                  !timerStopped
            else {
                //print(startDate)
                return
            }
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)

            self.secondsElapsed = secondsElapsed
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

        }
    }
    
    /**
     Reset the timer with a new meeting length.
     
     - Parameters:
         - lengthInMinutes: The meeting length.
     */
    func reset(lengthInMinutes: Int, attendees: [DailyTask.Question]) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}
extension Array<DailyTask.Question> {
    var speakers: [DiagnosticTimer.Speaker] {
        if isEmpty {
            return [DiagnosticTimer.Speaker(name: "Speaker 1", isCompleted: false)]
        } else {
            return map { DiagnosticTimer.Speaker(name: $0.name, isCompleted: false) }
        }
    }
}

