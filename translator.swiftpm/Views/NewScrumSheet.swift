/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = DailyTask.emptyScrum
    @Binding var scrums: [DailyTask]
    @Binding var isPresentingNewScrumView: Bool
    //@FocusState var isFocusOnDescription: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(scrums: .constant(DailyTask.sampleData), isPresentingNewScrumView: .constant(true))
    }
}
