/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import CoreML

struct HistoryView: View {
    let history: History
    let SEN = SentimentAnalyst()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                    Text("Sugesstion")
                        .font(.headline)
                    if(transcript.count == 0){
                        Text("We can not detect your feeling, please do the test again")
                    }else{
                        Text("You seem \(SEN.findAnswer(document: transcript))")
                    }

                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(
                transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI...")
    }
    
    static var previews: some View {
        HistoryView(history: history)
    }
}
