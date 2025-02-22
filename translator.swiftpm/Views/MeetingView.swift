/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyTask
    @StateObject var scrumTimer = ScrumTimer()
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
                    .fill(scrum.theme.mainColor)
                VStack {
                    MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                    MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme, onTranscriptionToggle: endScrumAndNavigate)
                    //MeetingFooterView(speakers: scrumTimer.speakers,skipAction: scrumTimer.skipSpeaker)
                }
            }
            .padding()
            .foregroundColor(scrum.theme.accentColor)
            .onAppear {
                startScrum()
            }
            .onDisappear {
                endScrum()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.questionlist)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistory = History(transcript: speechRecognizer.transcript)
        scrum.history.insert(newHistory, at: 0)
    }
    
    private func endScrumAndNavigate() {
            scrumTimer.stopScrum()
            speechRecognizer.stopTranscribing()
            isRecording = false
            let newHistory = History(transcript: speechRecognizer.transcript)
            scrum.history.insert(newHistory, at: 0)
            isMeetingDismissed = true
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyTask.sampleData[0]))
    }
}
