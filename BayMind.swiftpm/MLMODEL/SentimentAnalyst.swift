//
//  SentimentAnalysis.swift
//  Baymind
//
//  Created by Viet Hoang on 4/2/25.
//

import CoreML

class SentimentAnalyst{
    
    let valid_answer = ["0":"sadness",
                        "1":"joy",
                        "2":"love",
                        "3":"anger",
                        "4":"fear",
                        "5":"surprise"]
    let reversed = ["sadness":0,
                        "joy":1,
                        "love":2,
                        "anger":3,
                        "fear":4,
                        "surprise":5]

    
    /// The underlying Core ML Model.
    var SentModel: Sentclass {
        do {
            let defaultConfig = MLModelConfiguration()
            return try Sentclass(configuration: defaultConfig)
        } catch {
            fatalError("Couldn't load Sentiment model due to: \(error.localizedDescription)")
        }
    }

    ///   Classification sentiment of the user base on input text
    ///
    /// - `Classification label`:
    ///     - sadness (0)
    ///     - joy (1)
    ///     - love (2)
    ///     - anger (3)
    ///     - fear (4)
    ///
    /// - parameters:
    ///     - document: The user's input.
    /// - returns: The answer string or an error descripton.
    func findAnswer(document: String) -> String {
        // Prepare the input
        let User_Input = document
        print(User_Input)
        // The MLFeatureProvider that supplies the BERT model with its input MLMultiArrays.
        let modelInput = User_Input
        
        // Make a prediction with the Sent model.
        guard let prediction = try? SentModel.prediction(text: modelInput) else {
            return "The Sentiment model is unable to make a prediction."
        }
        print(prediction.label)
        // Analyze the output form the BERT model.
        guard let bestAnsIndices = valid_answer[prediction.label] else {
            return "Couldn't find a valid answer. Please try again."
        }
        
        // Return the decode of the original string as the answer.
        return bestAnsIndices
    }
}
