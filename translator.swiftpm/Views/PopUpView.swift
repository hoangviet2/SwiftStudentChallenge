//
//  PopUpview.swift
//  translator
//
//  Created by Viet Hoang on 19/2/25.
//

import SwiftUI

struct PopUpView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // Blurred background
            Color.black.opacity(isPresented ? 0.3 : 0)
                .ignoresSafeArea()
                .blur(radius: isPresented ? 10 : 0)
            VStack() {
                ScrollView{
                    Text("Welcome to BayMind")
                    Spacer()
                    ForEach(IntroContent.guidance) { introContent in
                        VStack(alignment: .leading, spacing: 7){
                            HStack(alignment: .top, spacing: 12){
                                Label("",systemImage: "\(introContent.milestone)")
                            }
                            Text(introContent.milestonename)
                                .font(.caption.weight(.bold))
                                .textCase(.uppercase)
                                .foregroundStyle(Color.gray)
                            Text(introContent.title)
                                .fontWeight(.semibold)
                            Divider()
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 13, trailing: 0))
                            Text(introContent.description)
                                .font(.footnote)
                                .padding(.bottom)
                            
                            if let contentSteps = introContent.steps {
                                ForEach(contentSteps) { step in
                                    HStack(alignment: .top, spacing: 14){
                                        Label("\(step.text)",systemImage: "\(step.no)")
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                        }
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 25)
                }
                Button(action: {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isPresented = false
                    }
                }) {
                    Text("Let's explore")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
            }
            .frame(width: 300)
            .frame(height: 450)
            .padding(.vertical, 30)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 10)
            .opacity(isPresented ? 1 : 0)
            .scaleEffect(isPresented ? 1 : 0.8)
            .animation(.spring(), value: isPresented)
        }
    }
}

struct PopUpView_preview: PreviewProvider {
    static var previews: some View {
        PopUpView(isPresented: .constant(true))
    }
}

struct IntroContent: Identifiable {
    let id = UUID()
    let milestone: String
    let milestonename: String
    let title: String
    let description: String
    let steps: [GuidanceSteps]?
    
    struct GuidanceSteps: Identifiable {
        let id = UUID()
        let no: String
        let text: String
    }
}

extension IntroContent{
    static let guidance : [IntroContent] = [
        IntroContent(
            milestone: "squareroot",
            milestonename: "Topic choosing",
            title: "Why I choose this topic?",
            description: "Welcome to BayMind, I chose the name BayMind because I am very impressed by how the robot BayMax takes care of his master. When I study abroad in the U.S., the speed of each lecture is much different from that of my home country. I struggle with the stress of homework, tests, quizzes,... Someday, even though my mood was terrible, I had to get up, study, and get through it without any break time. I created this app to remind me and someone like me to stop, breathe, and take a break.",
            steps: nil),
        IntroContent(
            milestone: "angle",
            milestonename: "BayMind",
            title: "Task manager + Sentiment self created AI",
            description: "I have built this app like a smart to-do list. This app will manage your task and sort it by the deadline. When you finish your task, the app will ask you to talk about your feelings and describe your thinking about the following task. By using sentiment analysis AI, it can detect whenever you need a break.",
            steps: nil),
        IntroContent(
            milestone: "compass.drawing",
            milestonename: "User guidance",
            title: "Add and solve",
            description: "First, let's see how you can add a task and a deadline for it!",
            steps: [
                GuidanceSteps(no: "die.face.1.fill",
                              text: "At the home screen, you can tap the + button int the top-right of the screen "),
                GuidanceSteps(no: "die.face.2.fill",
                              text: "You can add the title, try the most catchy as you can"),
                GuidanceSteps(no: "die.face.3.fill",
                              text: "Fill the rest of the information like the Priority - how emerge that is, theme of it some notes about it."),
                GuidanceSteps(no: "die.face.4.fill",
                              text: "Do not forget to choose your deadline!, and press add on the top right")
            ]),
        IntroContent(
            milestone: "plus.forwardslash.minus",
            milestonename: "User guidance",
            title: "If I need to edit?",
            description: "Very simple, just click on the task's card, you will see all your task's informations, on the top-right, there is edit button!",
            steps: [
                GuidanceSteps(no: "die.face.1.fill",
                              text: "At the card view, you can tap the edit button in the top-right of the screen "),
                GuidanceSteps(no: "die.face.2.fill",
                              text: "Now, just change whatever you want"),
                GuidanceSteps(no: "die.face.3.fill",
                              text: "Do not forget to press done to save all of your changes")
            ]),
        IntroContent(
            milestone: "minus.forwardslash.plus",
            milestonename: "User guidance",
            title: "What if I done?",
            description: "Congrats, you did it! But let's us check if you need a break or not!",
            steps: [
                GuidanceSteps(no: "die.face.1.fill",
                              text: "At the card view, you can tap the Done button!"),
                GuidanceSteps(no: "die.face.2.fill",
                              text: "Now, just answer the questions on the screen by talking to the mic"),
                GuidanceSteps(no: "die.face.3.fill",
                              text: "Do not forget to go back and see your diagnostic")
            ]),
        IntroContent(
            milestone: "function",
            milestonename: "Inspiration",
            title: "How I did the diagnostic",
            description: "I have trained a coreML model by using text classification and transcribing your speech by Speech framework.",
            steps: [
                GuidanceSteps(no: "die.face.1.fill",
                              text: "By create ML, I using the Emotion Dataset for Emotion Recognition Tasks on kaggle to classify the text into emotion labels"),
                GuidanceSteps(no: "die.face.2.fill",
                              text: "Then I add it into the project"),
                GuidanceSteps(no: "die.face.3.fill",
                              text: "You will see your result when you go back the card view.")
                
            ]),
        IntroContent(
            milestone: "sum",
            milestonename: "Reference",
            title: "About and Sources",
            description: "This project created by Viet Hoang in February 2025 as a submission for Student Swift challenge 2025. The dataset use on kaggle with the license CC0 from: https://www.kaggle.com/datasets/parulpandey/emotion-dataset/data. The usage is granted by license, allowing free use of the sound assets for commercial and non-commercial purposes. The UI design was partially inspired by Apple's Transcribing speech to text sample code, model structure is inspired by image classification sample code by Apple.",
            steps:nil),
    ]
    
}
