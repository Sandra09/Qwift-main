//
//  Welcome.swift
//  Qwift
//
//  Created by Student on 8/6/21.
//

import SwiftUI
import Firebase

struct Welcome: View {
    @State var emailField: String = ""
    @State var password: String = ""
    @State var fullName: String = ""
    @State var dob: String = ""
    @State var login = false

    
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
                        isPresented.toggle()
                    } label: {
            
                        HStack {
                            Spacer()
                            Text(login ? "LOGIN"
                                 : "Create Account")
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
            .fullScreenCover(isPresented: $isPresented, content: Home.init)

            .navigationTitle(login ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    @State private var isPresented = false
    
    private func handleAction() {
        if login{
            loginUser()
            
            //print("Should log into firebase with exisiting information")
        } else{
            createNewAccount()
            //print("Register a new account inside of Firebase Auth")
        }
    }
    
    
    private func loginUser() {
        Auth.auth().signIn(withEmail: emailField, password: password) {
            result, err in
            if let err = err {
                print("Could not login user: ", err)
                self.loginStatusMessage = "Could not login user: \(err)"
                return
            }
            print("User logged in successfully: \(result?.user.uid ?? "")")
            
            //self.loginStatusMessage = "User logged in successfully: \(result?.user.uid ?? "")"
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount(){
        Auth.auth().createUser(withEmail: emailField, password: password) {
            result, err in
            if let err = err {
                print("Could not creater user: ", err)
                self.loginStatusMessage = "Could not creater user: \(err)"
                return
            }
            print("User created successfully: \(result?.user.uid ?? "")")
            
            //self.loginStatusMessage = "User created successfully: \(result?.user.uid ?? "")"
        }
    }
    
   
}
