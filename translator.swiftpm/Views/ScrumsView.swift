/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyTask]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            
            List($scrums.sorted(by: {
                if $0.isDone.wrappedValue == $1.isDone.wrappedValue {
                    return $0.deadline.wrappedValue < $1.deadline.wrappedValue
                }
                return !$0.isDone.wrappedValue && $1.isDone.wrappedValue
            })) { $scrum in
                //if(scrum.isDone == false){
                    NavigationLink(destination: DetailView(scrum: $scrum)) {
                        CardView(scrum: scrum)
                    }
                    .listRowBackground(scrum.theme.mainColor)

                //}
            }
            .navigationTitle("Greeting,")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New to-do")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyTask.sampleData), saveAction: {})
    }
}
