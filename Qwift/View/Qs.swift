//
//  QA.swift
//  Quiz
//
//  Created by Student on 8/6/21.
//

import SwiftUI
import UIKit

// question Answser View...
struct Qs: View {
    
    @Binding var correct : Int
    @Binding var wrong: Int
    @Binding var answered: Int
    var set: String
    var total : Double {
        get {
            Double(100 * correct / wrong)
        }
    }
    
    @StateObject var data = QuestionViewModel()
    
    @Environment(\.presentationMode) var present
    
    
    var body: some View {
       
        ZStack{
            
            if data.questions.isEmpty{
                
                ProgressView()
            }
            else{
                
                if answered == data.questions.count{
                    
                    VStack(spacing: 25){
                        
                        Text("Well Done !!!")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        // Score And Back To Home Button...
                        
                        HStack(spacing: 15){
                            
                            Text("\(correct) / \(wrong)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            Text("\(total, specifier: "%.2f")%")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            // closing sheet....
                            present.wrappedValue.dismiss()
                            answered = 0
                            correct = 0
                            wrong = 0
                        }, label: {
                            Text("Return Home")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color.blue)
                                .cornerRadius(15)
                        })
                    }
                }
                else{
                    
                    VStack{
                        
                        // Top Progress View...
                        
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                            
                            Capsule()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(Color.green)
                                .frame(width: progress(), height: 6)
                        })
                        .padding()
                        
                        ZStack{
                            
                            ForEach(data.questions.reversed().indices){index in
                                
                                // View...
                                
                                QuestionView(question: $data.questions[index], correct: $correct, wrong: $wrong, answered: $answered)
                                // if current question is completed means moving away...
                                    .offset(x: data.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.questions[index].completed ? 10 : 0))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        // fetching...
        .onAppear(perform: {
        
            data.getQuestions(set: set)
        })
    }
    
    // progres...
    
    func progress()->CGFloat{
        
        let fraction = CGFloat(answered) / CGFloat(data.questions.count)
        
        let width = UIScreen.main.bounds.width - 30
        
        return fraction * width
    }
}
// code reference @Kavsoft on YouTube 

