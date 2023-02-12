//
//  homeView.swift
//  Client
//
//  Created by 高山 on 2023/1/26.
//

import SwiftUI

struct homeView: View {
//    @Environment(\.presentationMode) var presentationMode

    @State var signUpState = false
    @State var loginState = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()

                Image(systemName: "book.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)

                Text("Borrow your book.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .overlay(
                        Capsule(style: .continuous)
                            .frame(height: 3)
                            .offset(y: 5)
                            .foregroundColor(.white),
                        alignment: .bottom
                    )

                Text("This software is designed to help you borrow and return books smoothly.")
                    .fontWeight(.medium)
                    .foregroundColor(.white)

                Spacer()
                Spacer()

                // Although deprecated but easy to use!
                NavigationLink(destination: registerView(),
                               isActive: $signUpState) {
                    EmptyView()
                }
                NavigationLink(destination: loginView(),
                               isActive: $loginState) {
                    EmptyView()
                }

                signUpButton
                loginButton
            }
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.blue)
        }
    }

    var signUpButton: some View {
        Text("SIGN UP")
            .font(.headline)
            .foregroundColor(.blue)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 15)
            .onTapGesture {
                handleSignUpButtonPressed()
            }
    }

    var loginButton: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.blue)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 15)
            .onTapGesture {
                handleloginButtonPressed()
            }
    }
}

extension homeView {
    func handleSignUpButtonPressed() {
        signUpState.toggle()
    }

    func handleloginButtonPressed() {
        loginState.toggle()
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
