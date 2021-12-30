//
//  Home.swift
//  Qwift
//
//  Created by Student on 8/6/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var qUser: QUser?
    
    @Published var isUserCurrentlyLoggedOut = false
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
                    self.errorMessage = "Could not find uid"
                    return
                }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument{ snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user: \(error)"
                    print("Failed to fetch current user:", error)
                    return
                }
                
                guard let data = snapshot?.data() else {
                    self.errorMessage = "No data found"
                    return
                }
            
                self.qUser = .init(data: data)
            }
    }
        
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
    
}

struct Home: View {
    
    @State var show = false
    @State var logOutOptions = false
    
    //Storing level for fetching questions...
    @State var set = "Quiz_1"
    
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    
    @ObservedObject private var vm = HomeViewModel()
        
    var body: some View {
        VStack{
            
            customNavBar
            
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
    
    private var customNavBar: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color.black, lineWidth: 1))
            VStack(alignment: .leading){
                let email = vm.qUser?.email.replacingOccurrences(of: "@yahoo.com", with: "") ?? ""
                Text(email)
                    .font(.system(size: 24, weight: .bold))
            }
            Spacer()
            Button {
                logOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
            .actionSheet(isPresented: $logOutOptions) {
                .init(title: Text("Settings"), message:
                        Text("What do you want to do?"), buttons: [
                            .destructive(Text("Sign Out"), action: {
                                print("Handle sign out")
                                vm.handleSignOut()
                            }),
                                .cancel()
                        ])
            }
            .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
                Welcome(didLogin: {
                self.vm.isUserCurrentlyLoggedOut = false
                self.vm.fetchCurrentUser()
            })
        }
    }
}
