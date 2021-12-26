//
//  QuestionViewModel.swift
//  Qwift
//
//  Created by Student on 8/6/21.
//

import SwiftUI
import Firebase

class QuestionViewModel: ObservableObject {
    @Published var questions : [Question] = [].shuffled()
    
    func getQuestions(set: String){
        let db = Firestore.firestore()
        
        //change this to set....
        if set == "Quiz_1" {
            
            db.collection("Quiz_1").getDocuments{ (snap, err) in
                guard let data = snap else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.questions = data.documents.compactMap({ (doc) -> Question? in
                        return try? doc.data(as: Question.self)
                    })
                }
            
            }
        } else if set == "Quiz_2" {
            db.collection("Quiz_2").getDocuments{ (snap, err) in
                guard let data = snap else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.questions = data.documents.compactMap({ (doc) -> Question? in
                        return try? doc.data(as: Question.self)
                    })
                }
            
            }
        }
    }
    
}
