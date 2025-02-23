import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var task: DailyTask
    @StateObject var taskTimer = DiagnosticTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State private var errorWrapper: ErrorWrapper?
    @State private var isTransit = false
    @State private var isMeetingDismissed = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(task.theme.mainColor)
                VStack {
                    MeetingHeaderView(secondsElapsed: taskTimer.secondsElapsed, secondsRemaining: taskTimer.secondsRemaining, theme: task.theme)
                    MeetingTimerView(speakers: taskTimer.speakers, isRecording: isRecording, theme: task.theme, onTranscriptionToggle: endTaskAndNavigate)
                }
            }
            .padding()
            .foregroundColor(task.theme.accentColor)
            .onAppear {
                startTimer()
            }
            .onDisappear {
                endTimer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func startTimer() {
        taskTimer.reset(lengthInMinutes: task.lengthInMinutes, attendees: task.questionlist)
        taskTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        taskTimer.startTimer()
    }
    
    private func endTimer() {
        taskTimer.stopTimer()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistory = History(transcript: speechRecognizer.transcript)
        task.history.insert(newHistory, at: 0)
    }
    
    private func endTaskAndNavigate() {
            taskTimer.stopTimer()
            speechRecognizer.stopTranscribing()
            isRecording = false
            let newHistory = History(transcript: speechRecognizer.transcript)
            task.history.insert(newHistory, at: 0)
            isMeetingDismissed = true
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(task: .constant(DailyTask.sampleData[0]))
    }
}
