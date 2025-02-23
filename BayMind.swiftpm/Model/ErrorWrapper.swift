//
//  SentimentAnalysis.swift
//  Baymind
//
//  Created by Viet Hoang on 5/2/25.
//
import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
