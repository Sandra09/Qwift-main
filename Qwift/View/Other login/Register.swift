//
//  Register.swift
//  Qwift
//
//  Created by Student on 1/23/22.
//

import SwiftUI

struct Register: View {
    
    @State var email = ""
    @State var password = ""
    @State var fullName = ""
    @State var dob = ""
    
    @Binding var show : Bool
    @Namespace var animation

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack{
                
                HStack{
                    
                    Button(action: {show.toggle()}){
                        
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
                .padding(.leading)

                HStack{
                    
                    Text("Create Account")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading)
                
                CustomTextField(image: "person", title: "FULL NAME", value: $fullName, animation: animation)
                CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                    .padding(.top,5)
                CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                    .padding(.top,5)
                CustomTextField(image: "calendar", title: "BIRTHDAY", value: $dob, animation: animation)
                    .padding(.top,5)
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {handleAction()}){
                        
                        HStack(spacing: 10){
                            
                            Text("SIGN UP")
                                .fontWeight(.heavy)
                            
                            Image(systemName: "arrow.right")
                                .font(.title2)
                        }
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,35)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color("orange-light"),Color.orange]), startPoint: .leading, endPoint: .trailing)
                        )
                    }
                    .clipShape(Capsule())
                }
                .padding()
                .padding(.top)
                .padding(.trailing)
                
                HStack{
                    
                    Text("Already registered?")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Button(action: {show.toggle()}){
                        
                        Text("sign in")
                            .fontWeight(.heavy)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                .padding(.top,10)
                
            }
        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func handleAction() {
        if show{
            createNewAccount()
            
            //print("Register a new account inside of Firebase Auth")
        }
    }
        
    @State var loginStatusMessage = ""
    
    private func createNewAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                //print("Could not creater user: ", err)
                self.loginStatusMessage = "Could not creater user: \(err)"
                return
            }
            //print("User created successfully: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "User created successfully: \(result?.user.uid ?? "")"
        }
    }
}
