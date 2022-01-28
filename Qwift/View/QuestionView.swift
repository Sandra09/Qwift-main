//
//  QuestionView.swift
//  Qwift
//
//  Created by Student on 8/6/21.
//

import SwiftUI
import UIKit

struct QuestionView: View {
    @Binding var question : Question
    @Binding var correct : Int
    @Binding var wrong : Int
    @Binding var answered: Int
   // @Binding var total : Int
    
    @State var selected = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22){
            
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 25)
            Spacer(minLength: 0)
            
            //Options...
            
            Button(action: {selected = question.optionA!}, label: {
                Text(question.optionA!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .stroke(color(option: question.optionA!),lineWidth: 2)
                    )
            })
            
            Button(action: {selected = question.optionB!}, label: {
                Text(question.optionB!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .stroke(color(option: question.optionB!),lineWidth: 2)
                    )
            })
            
            Button(action: {selected = question.optionC!}, label: {
                Text(question.optionC!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .stroke(color(option: question.optionC!),lineWidth: 2)
                    )
            })
            
            Button(action: {selected = question.optionD!}, label: {
                Text(question.optionD!)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .stroke(color(option: question.optionD!),lineWidth: 2)
                    )
            })
            
            Spacer(minLength: 0)
            
            //Buttons...
            
            HStack(spacing: 15){
                
                Button(action: checkAns, label: {
                    Text("Submit")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
                //disabling...
                .disabled(question.isSumitted ? true : false)
                .opacity(question.isSumitted ? 0.7 : 1)
                
                Button(action: {withAnimation{question.completed.toggle()
                    answered += 1
                }}, label: {
                    Text("Next")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                })
                //disabling...
                .disabled(!question.isSumitted ? true : false)
                .opacity(!question.isSumitted ? 0.7 : 1)
            }
            .padding(.bottom)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
    }
    
    //highlighting answer...
    func color(option: String)-> Color{
        
        if option == selected{
            
            //displaying if correct means green else red...
            if question.isSumitted{
                if selected == question.answer!{
                    return Color.green
                }
                else {
                    return Color.red
                }
            }
            else {
                return Color.blue
            }
        }
        else{
            //displaying right if wrong selected....
            if question.isSumitted && option != selected{
                if question.answer! == option{return Color.green}
            }
            return Color.gray
        }
    }
    // check answer...
    func checkAns(){
        
        if selected == question.answer!{
            correct += 1
        }
        else{
            wrong += 1
        }
        question.isSumitted.toggle()
    }
}
// code reference @Kavsoft on YouTube 

