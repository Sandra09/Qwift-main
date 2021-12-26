
//  Question.swift
//  Qwift
//
//  Created by Student on 8/6/21.

import SwiftUI
import FirebaseFirestoreSwift

// Codable Model...

struct Question: Identifiable, Codable {
    
    // it will fetch doc ID...
    @DocumentID var id: String?
    var question : String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var optionD: String?
    var answer: String?

    // for checking...
    var isSumitted = false
    var completed = false

    // declare  the coding keys with respect to firebase firestone Key...

    enum CodingKeys: String, CodingKey {
        case question
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case optionD = "d"
        case answer
    }
}

