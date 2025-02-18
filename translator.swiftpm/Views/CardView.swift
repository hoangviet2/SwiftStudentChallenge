/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                if(scrum.deadline < Date()){
                    Label("\(scrum.deadline.formatted(.dateTime))", systemImage: "checkmark.circle")
                        .foregroundStyle(.red)
                }else{
                    Label("\(scrum.deadline.formatted(.dateTime))", systemImage: "checkmark.circle")
                }
                
                    
                    //.accessibilityLabel("4 attendees")
                Spacer()
                Label("Priority: ", systemImage: "\(scrum.priority.displayImage)")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.sampleData[0]
    static var previews: some View {
        CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
