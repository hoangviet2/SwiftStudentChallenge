import SwiftUI

struct CardView: View {
    let task: DailyTask
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                if(task.isDone == true){
                    Label("DONE", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }else{
                    if(task.deadline < Date()){
                        Label("\(task.deadline.formatted(.dateTime))", systemImage: "checkmark.circle")
                            .foregroundStyle(.red)
                    }else{
                        Label("\(task.deadline.formatted(.dateTime))", systemImage: "checkmark.circle")
                    }
                }
                Spacer()
                Label("Priority: ", systemImage: "\(task.priority.displayImage)")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(task.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var task = DailyTask.sampleData[0]
    static var previews: some View {
        CardView(task: task)
            .background(task.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
