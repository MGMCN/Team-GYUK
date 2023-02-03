//
//  loginpage.swift
//  Client
//
//  Created by GAO SHAN on 2023/01/26.
//

import Foundation
import SwiftUI

struct FocusStateBootcamp: View {
    
    enum OnboardingField: Hashable {
        case email
        case password
    }
    
//    @FocusState private var usernameInFocus: Bool
    @State private var email: String = ""
//    @FocusState private var passwordInFocus: Bool
    @State private var password: String = ""
    @State var showPwd = false // This state indicates whether you want to see the plaintext password
    @FocusState private var fieldInFocus: OnboardingField?

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            // big logo field
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Image(systemName: "book.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            Spacer()
            
            // email field
            HStack {
                Image(systemName: "envelope.circle.fill")
                    .foregroundColor(.white)
                    .font(.title3)
                Text("Email")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            TextField("Your email here...", text: $email)
                .focused($fieldInFocus, equals: .email)
//                .focused($usernameInFocus)
                .padding(.leading)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
            
            // password field
            HStack {
                Image(systemName: "lock.circle.fill").foregroundColor(.white)
                    .font(.title3)
                Text("Password")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            ZStack(alignment: .trailing) {
                if showPwd {
                    TextField("Your password here...", text: $password)
                        .focused($fieldInFocus, equals: .password)
                        .font(.headline)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(15)
                } else {
                    SecureField("Your password here...", text: $password)
                        .focused($fieldInFocus, equals: .password)
        //                .focused($passwordInFocus)
                        .padding(.leading)
                        .frame(height: 55)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(15)
                }
                Button(
                    action: {
                        self.showPwd.toggle()
                    }) {
                        Image(systemName: self.showPwd ?"eye" : "eye.slash")
                    }
                    .padding()
            }
            
            // login button field
            HStack(){
                Spacer()
                Button(
                    action: {
                        let usernameIsValid = !email.isEmpty
                        let passwordIsValid = !password.isEmpty
                        if usernameIsValid && passwordIsValid {
                            print("Login")
                        } else if usernameIsValid {
                            fieldInFocus = .password
        //                    usernameInFocus = false
        //                    passwordInFocus = true
                        } else {
                            fieldInFocus = .email
        //                    usernameInFocus = true
        //                    passwordInFocus = false
                        }
                    }) {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Text("Login Now")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                            .shadow(radius: 15)
                    }
                    .padding()
                Spacer()
            }
//            Button("TOGGLE FOCUS STATE") {
//                usernameInFocus.toggle()
//            }
        }
        .frame(maxHeight: .infinity)
        .padding()
        .background(Color.blue)
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.usernameInFocus = true
//            }
//        }
    }
}

struct FocusStateBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FocusStateBootcamp()
    }
}
