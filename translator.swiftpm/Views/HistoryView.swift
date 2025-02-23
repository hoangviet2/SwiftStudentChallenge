/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import CoreML

struct HistoryView: View {
    let history: History
    let SEN = SentimentAnalyst()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 7) {
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                    if(transcript.count == 0){
                        Text("We can not detect your feeling, please do the test again")
                    }else{
                        let guidanceBaseOnTest = SuggestionContent.cureguidance[SEN.reversed[SEN.findAnswer(document: transcript)]!]
                        Text(guidanceBaseOnTest.intro)
                            .fontWeight(.semibold)
                            .font(.headline)
                        Divider()
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 13, trailing: 0))
                        Text(guidanceBaseOnTest.description)
                            .padding(.bottom)
                        if let sicks = guidanceBaseOnTest.sick {
                            ForEach(sicks) { step in
                                HStack(alignment: .top, spacing: 14){
                                    Label("\(step.text)",systemImage: "\(step.no)")
                                }
                                .padding(.bottom, 10)
                            }
                        }
                        Divider()
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 13, trailing: 0))
                        if guidanceBaseOnTest.smallIntro != nil{
                            Text(guidanceBaseOnTest.smallIntro!)
                                .fontWeight(.semibold)
                                //.padding(.bottom)
                        }
                        if let contentSteps = guidanceBaseOnTest.cureStep {
                            ForEach(contentSteps) { step in
                                HStack(alignment: .top, spacing: 14){
                                    Label("\(step.text)",systemImage: "\(step.no)")
                                }
                                .padding(.bottom, 10)
                            }
                        }
                        
                    }
                    
                }
            }
            .navigationTitle(Text(history.date, style: .date))
            .padding(.horizontal, 25)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}



struct SuggestionContent: Identifiable {
    let id = UUID()
    let intro: String
    let description: String
    let sick: [cureSteps]?
    let smallIntro : String?
    let cureStep: [cureSteps]?
    
    struct cureSteps: Identifiable {
        let id = UUID()
        let no: String
        let text: String
    }
}

extension SuggestionContent{
    static let cureguidance : [SuggestionContent] = [
        SuggestionContent(intro: "Are you sad?",
                          description: "Long-term sadness can have a detrimental effect on mental health, frequently resulting in stress and even depression. Long-lasting sorrow can sap vitality, lower motivation, and make even easy tasks seem impossible. Over time, this emotional weight can increase: ",
                          sick: [
                            cureSteps(no: "die.face.1.fill", text: "stress levels"),
                            cureSteps(no: "die.face.2.fill", text: "sleep disturbances"),
                            cureSteps(no: "die.face.3.fill", text: "headaches"),
                          ],
                          smallIntro: "No Worries, I have some suggestions by WHO - World Health Organization for you: ",
                          cureStep: [
                            cureSteps(no: "die.face.1.fill", text: "exercise regularly, even if it’s just a short walk"),
                            cureSteps(no: "die.face.2.fill", text: "talk to someone you trust about your feelings"),
                            cureSteps(no: "die.face.3.fill", text: "seek help from a healthcare provider if you need!"),
                            cureSteps(no: "die.face.4.fill", text: "If you have thoughts of suicide remember you are not alone, and that many people have gone through what you’re experiencing and found help"),
                            cureSteps(no: "die.face.5.fill", text: "Now, take a break for 10 minutes"),
                          ]),
        SuggestionContent(intro: "Greate you enjoy it!",
                          description: "There are several advantages to happiness for one's physical and mental health.  By reducing cortisol levels, joy helps you feel less stressed and more focused.  Additionally, it strengthens the immune system, increasing the body's resistance to disease.  Joy improves relationships on an emotional level by encouraging optimism, empathy, and closer bonds with other people.  A positive outlook makes it simpler to approach obstacles with hope and boosts creativity and productivity.",
                          sick: nil,
                          smallIntro: "Here are something you could do to stay joyful",
                          cureStep: [
                            cureSteps(no: "die.face.1.fill", text: "Practice Gratitude"),
                            cureSteps(no: "die.face.2.fill", text: "Engage in Activities You Love"),
                            cureSteps(no: "die.face.3.fill", text: "Take Care of Your Mind and Body"),
                            cureSteps(no: "die.face.4.fill", text: "Now, drink something and go back to work!")
                          ]),
        SuggestionContent(intro: "Greate you enjoy it!",
                          description: "There are several advantages to happiness for one's physical and mental health.  By reducing cortisol levels, joy helps you feel less stressed and more focused.  Additionally, it strengthens the immune system, increasing the body's resistance to disease.  Joy improves relationships on an emotional level by encouraging optimism, empathy, and closer bonds with other people.  A positive outlook makes it simpler to approach obstacles with hope and boosts creativity and productivity.",
                          sick: nil,
                          smallIntro: "Here are something you could do to stay joyful",
                          cureStep: [
                            cureSteps(no: "die.face.1.fill", text: "Practice Gratitude"),
                            cureSteps(no: "die.face.2.fill", text: "Engage in Activities You Love"),
                            cureSteps(no: "die.face.3.fill", text: "Take Care of Your Mind and Body"),
                            cureSteps(no: "die.face.4.fill", text: "Now, drink something and go back to work!")
                          ]),
        SuggestionContent(intro: "Are you mad?",
                          description: "Long-term mad can have a detrimental effect on mental health, frequently resulting in stress and even depression. Long-lasting sorrow can sap vitality, lower motivation, and make even easy tasks seem impossible. Over time, this emotional weight can increase: ",
                          sick: [
                            cureSteps(no: "die.face.1.fill", text: "stress levels"),
                            cureSteps(no: "die.face.2.fill", text: "sleep disturbances"),
                            cureSteps(no: "die.face.3.fill", text: "headaches"),
                          ],
                          smallIntro: "No Worries, I have some suggestions for you: ",
                          cureStep: [
                            cureSteps(no: "die.face.1.fill", text: "practice deep breathing exercises"),
                            cureSteps(no: "die.face.2.fill", text: "take a time-out"),
                            cureSteps(no: "die.face.3.fill", text: "try to express your concerns calmly once you've cooled down"),
                            cureSteps(no: "die.face.4.fill", text: "Now, grab a drink and go back to work!")
                          ]),
        SuggestionContent(intro: "Are you fear?",
                          description: "Fear can cause anxiety, stress, and a sense of being overwhelmed. It can lead to negative thinking patterns, where a person anticipates danger or failure, even in safe situations. Over time, persistent fear can contribute to mental health issues like depression or chronic anxiety. Over time, this emotional weight can increase: ",
                          sick: [
                            cureSteps(no: "die.face.1.fill", text: "racing heart"),
                            cureSteps(no: "die.face.2.fill", text: "sweaty palms"),
                            cureSteps(no: "die.face.3.fill", text: "shallow breathing"),
                          ],
                          smallIntro: "No Worries, I have some suggestions for you: ",
                          cureStep: [
                            cureSteps(no: "die.face.1.fill", text: "practice deep breathing exercises"),
                            cureSteps(no: "die.face.2.fill", text: "take a time-out"),
                            cureSteps(no: "die.face.3.fill", text: "Now, take a time-out for 5 minutes and grab a drink and go back to work!")
                          ]),
        SuggestionContent(intro: "Are you suprise about it?",
                          description: "It could be great or not but at the end I believe that you could get it!",
                          sick:nil,
                          smallIntro: "No Worries,you should be fine. Grab a drink, take a break and go back to work!",
                          cureStep:nil)
    ]
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


