//
//  Welcome.swift
//  Qwift
//
//  Created by Student on 8/6/21.
//

import SwiftUI
import Firebase

struct Welcome: View {
    
    let didLogin: () -> ()
        
    @State private var emailField: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var dob: String = ""
    @State private var login = false

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $login, label:  Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Register")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Button {
                        
                    } label: {
                        Image("Qwift-logo")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(height:200)
                    }
                    
                    Group{
                        if login{
                            TextField("Email", text: $emailField)
                                .font(.system(size: 27))
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            SecureField("Password", text: $password)
                                .font(.system(size: 27))
                        }
                        
                        if !login {
                            TextField("FULL NAME", text: $fullName)
                                .font(.system(size: 27))
                            
                            TextField("EMAIL", text: $emailField)
                                .font(.system(size: 27))
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            SecureField("PASSWORD", text: $password)
                                .font(.system(size: 27))
                            
                            TextField("BIRTHDAY", text: $dob)
                                .font(.system(size: 27))
                                .keyboardType(.numberPad)
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
                        handleAction()
                    } label: {
            
                        HStack {
                            Spacer()
                            Text(login ? "LOGIN" : "Create Account")
                                .foregroundColor(.white) .padding(.vertical, 8)
                                .font(.system(size: 27, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                    Text(self.loginStatusMessage)
                        .foregroundColor(.red)
                }
                .padding()
            }

            .navigationTitle(login ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    private func handleAction() {
        if login{
            loginUser()
            //print("Should log into firebase with exisiting information")
        } else{
            createNewAccount()
            
            //print("Register a new account inside of Firebase Auth")
        }
    }
    
    @State private var currentUserlogin = false
    
    private func loginUser() {
        currentUserlogin.toggle()
        FirebaseManager.shared.auth.signIn(withEmail: emailField, password: password) {
            result, err in
            if let err = err {
                print("Could not login user: ", err)
                self.loginStatusMessage = "Could not login user: \(err)"
                return
            }
            print("User logged in successfully: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "User logged in successfully: \(result?.user.uid ?? "")"
            self.didLogin()
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: emailField, password: password) {
            result, err in
            if let err = err {
                print("Could not creater user: ", err)
                self.loginStatusMessage = "Could not creater user: \(err)"
                return
            }
            print("User created successfully: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "User created successfully: \(result?.user.uid ?? "")"
        }
    }
    
   
}
// code reference @CodeWithChris on YouTube 
