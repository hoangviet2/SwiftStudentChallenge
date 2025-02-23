//
//  SentimentAnalysis.swift
//  Baymind
//
//  Created by Viet Hoang on 22/2/25.
//
import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var transcript: String?
    var advantages: String?
    var feeling: String?
    var improving: String?
    
    init(id: UUID = UUID(), date: Date = Date(), transcript: String? = nil, advantages: String? = nil, feeling: String? = nil, improving: String? = nil) {
        self.id = id
        self.date = date
        self.transcript = transcript
        self.advantages = advantages
        self.feeling = feeling
        self.improving = improving
    }
}
