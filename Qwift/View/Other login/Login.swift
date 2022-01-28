//
//  Login.swift
//  Qwift
//
//  Created by Student on 1/22/22.
//

import SwiftUI

struct Login: View {
    
    let didLogin: () -> ()
    
    @State var email = ""
    @State var password = ""
    @Namespace var animation
    
    @State var show = false
    
    var  body: some View {
        
        VStack{
            
            Image("Qwift-logo")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(height:200)
                        
            HStack{
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Login")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.primary)
                    Text("Sign in to continue")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading)
            
            CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
            CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                .padding(.top,5)
            
            HStack{
                
                Spacer(minLength: 0)
                
                VStack(alignment: .trailing, spacing: 20){
                    
                    Button(action: {} ){
                        
                        HStack(spacing: 10){
                            
                            Text("LOGIN")
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
            }
            .padding()
            .padding(.top,10)
            .padding(.trailing)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 8){
                
                Text("Register?")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: Register(show: $show), isActive: $show){
                    
                    Text("Sign Up")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.orange)
                }
            }
            .padding()
        }
    }
    
    private func handleAction() {
        if show{
            loginUser()
            //print("Should log into firebase with exisiting information")
        }
    }
    
    @State private var currentUserlogin = false
    
    private func loginUser() {
        currentUserlogin.toggle()
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                //print("Could not login user: ", err)
                self.loginStatusMessage = "Could not login user: \(err)"
                return
            }
            //print("User logged in successfully: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "User logged in successfully: \(result?.user.uid ?? "")"
            self.didLogin()
        }
    }
    
    @State var loginStatusMessage = ""
    
}
