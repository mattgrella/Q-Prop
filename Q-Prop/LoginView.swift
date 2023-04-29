//
//  LoginView.swift
//  Q-Prop
//
//  Created by Matthew Grella on 4/28/23.
//

import SwiftUI
import Firebase
import UIKit
import FirebaseAuth

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorText = ""
    @State private var isSignUp = false
    @State private var isLogged = false
    var body: some View {
        if isLogged {
            Main()
        } else {
            VStack {
                
                Text("Q-Prop")
                    .font(Font.custom("Supreme", size: 100))
                    .bold()
                    .foregroundColor(.teal)
                    .multilineTextAlignment(.center)
                
                Image(systemName: "basketball")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.orange)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                if isSignUp {
                    Button(action: signUp) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                } else {
                    Button(action: signIn) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                }
                
                if showError {
                    Text(errorText)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Already have an account? Sign in" : "Don't have an account? Sign up")
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorText = error.localizedDescription
                showError = true
            } else {
                isLogged = true
            }
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorText = error.localizedDescription
                showError = true
            } else {
                isLogged = true
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
