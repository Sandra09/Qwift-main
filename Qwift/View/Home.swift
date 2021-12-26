//
//  Home.swift
//  Qwift
//
//  Created by Student on 8/6/21.
//

import SwiftUI

struct Home: View {
    @State var show = false
    
    //Storing level for fetching questions...
    @State var set = "Quiz_1"
    
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    let vc = UIViewController()
    
    var body: some View {
      
        VStack{
          Image("Qwift-logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height:300)
            
          Text("Qwift")
            .font(.system(size: 80))
            .fontWeight(.heavy)
            .foregroundColor(.orange)
            .padding(.top)
            
            Text("Know Your Swift.")
              .font(.title2)
              .fontWeight(.heavy)
              .foregroundColor(.black)
              .padding(.top,8)
              .multilineTextAlignment(.center)
            
            Spacer(minLength: 0)
            
            // Level View...
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 35, content: {
                
                // 2 levels..
                ForEach(1...2, id: \.self){index in
                    VStack(spacing: 30){
                        Text("Quiz \(index)")
                            .font(.system(size: 40))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    //opening Qs view as sheet..
                    .onTapGesture(perform: {
                        set = "Quiz_\(index)"
                        show.toggle()
                    })
                }
            })
            .padding()
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea())
        .sheet(isPresented: $show, content: {
            Qs(correct: $correct, wrong: $wrong, answered: $answered, set: set)
        })
    }
}
