/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let isRecording: Bool
    let theme: Theme
    @State private var isTranscriptionEnabled: Bool = true
    @Environment(\.dismiss) private var dismiss
    var onTranscriptionToggle: () -> Void
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text("You are able to talk")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay  {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
        // Toggle Button for Speech Transcription
        Button(action: {
            isTranscriptionEnabled.toggle()
            dismiss()
        }) {
            HStack {
                Image(systemName: isTranscriptionEnabled ? "checkmark.seal" : "checkmark.seal.fill")
                Text(isTranscriptionEnabled ? "Transcription On" : "Transcription Off")
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            //.animation(.easeInOut, value: isTranscriptionEnabled)
        }
        .padding(.top, 10)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(speakers: speakers, isRecording: true, theme: .yellow) {
            print("Hello")
        }
    }
}
