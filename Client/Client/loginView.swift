//
//  loginView.swift
//  Client
//
//  Created by Yamaoka and GAO SHAN on 2023/01/26.
//

import Foundation
import ProgressHUD
import SwiftUI

struct loginView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var keyboard = KeyboardResponder()

    enum OnboardingField: Hashable {
        case email
        case password
    }

    // make it static so other var can easily access
    @State var hide = false
    @State var loginState = false
//    @FocusState private var usernameInFocus: Bool
    @State private var email: String = ""
//    @FocusState private var passwordInFocus: Bool
    @State private var password: String = ""
    @State var showPwd = false // This state indicates whether you want to see the plaintext password
    @FocusState private var fieldInFocus: OnboardingField?

    var body: some View {
        let navi = NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                // big logo field
                Spacer()
                HStack {
                    Spacer()
                    VStack {
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
                .offset(y: -keyboard.keyboardHeight / 2)
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
                .offset(y: -keyboard.keyboardHeight / 2)
                TextField("Your email here...", text: $email)
                    .focused($fieldInFocus, equals: .email)
                    //                .focused($usernameInFocus)
                    .padding(.leading)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .offset(y: -keyboard.keyboardHeight / 2)

                // password field
                HStack {
                    Image(systemName: "lock.circle.fill").foregroundColor(.white)
                        .font(.title3)
                    Text("Password")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .offset(y: -keyboard.keyboardHeight / 2)
                ZStack(alignment: .trailing) {
                    if showPwd {
                        TextField("Your password here...", text: $password)
                            .focused($fieldInFocus, equals: .password)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(15)
                            .foregroundColor(.black)
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
                            .foregroundColor(.black)
                    }
                    Button(
                        action: {
                            self.showPwd.toggle()
                        }) {
                            Image(systemName: self.showPwd ?"eye" : "eye.slash")
                        }
                        .padding()
                }
                .offset(y: -keyboard.keyboardHeight / 2)

                // login button field
                HStack {
                    // use logout dont use navigationview back button
                    NavigationLink(destination: operationView(hide: self.$hide, email: $email, password: $password)
                        .navigationBarBackButtonHidden(true),
                        isActive: $loginState) {
                            EmptyView()
                        }
                    Spacer()
                    Button(
                        action: {
                            handleLoginButtonPressed()
                            // if login success hide above navigationbar(back button) -> set hide = true
                            self.hide = true
                        }) {
                            Image(systemName: "arrow.up.and.person.rectangle.portrait")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding([.bottom])
                            Text("Login Now")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.semibold)
                                .shadow(radius: 15)
                                .padding([.bottom, .trailing])
                        }
                        .offset(y: -keyboard.keyboardHeight / 2)
                        .padding()
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity)
            .padding()
            .background(Color.blue)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.backward.circle")
                    .foregroundColor(.white)
                    .font(.title3)
            })
        )

        navi.navigationBarHidden(self.hide)
    }
}

extension loginView {
    func handleLoginButtonPressed() {
        let usernameIsValid = !email.isEmpty
        let passwordIsValid = !password.isEmpty
        if usernameIsValid, passwordIsValid {
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
        // send email and pswd to server.

        // if return success do loginState.toggle()
        ProgressHUD.colorHUD = .lightGray
        ProgressHUD.showSucceed("Success !", delay: 0.75)
        loginState.toggle()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        // if return fail show alert message
    }
}

struct FocusStateBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
