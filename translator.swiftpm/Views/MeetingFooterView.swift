/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()->Void
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    private var isLastSpeaker: Bool {
        print(speakers.count)
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "It is the last question" }
        return "Question: \(speakerNumber) of \(speakers.count)"
//        return "Hihi, haha"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last question")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        //MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            //.previewLayout(.sizeThatFits)
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers,skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
