//
//  loginView.swift
//  Client
//
//  Created by Yamaoka and GAO SHAN on 2023/01/26.
//

import Alamofire
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
    @State var loginFailState = false
    @State var alertMessage = "Login failed !"
    @State var sessionkey = "sessionkey"
    @State var authtype = 1
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
                        .alert(isPresented: $loginFailState) {
                            Alert(
                                title: Text("Login Information"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK")) {
                                    alertMessage = "Login failed !"
                                }
                            )
                        }
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
        // send email and pswd to server.
        let parameters = ["email": email, "password": password]
        AF.request(urls.login_url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept": "application/json"]).responseJSON { response in
            if let data = response.data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let code = jsonObject?["code"] as? Int {
                        if code == 1 {
                            alertMessage = "Success !"
                            if let key = jsonObject?["session_key"] as? String {
                                sessionkey = key
                            }
                            if let type = jsonObject?["authtype"] as? Int {
                                authtype = type
                            }
                        } else {
                            if let message = jsonObject?["errorMessage"] as? String {
                                alertMessage = message
                            }
                        }
                    }
                } catch {
                    alertMessage = "Do JSONSerialization fail !"
                }
            }
            showLoginSuccessOrNot()
        }

        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func showLoginSuccessOrNot() {
        if alertMessage == "Success !" {
            account.set(username: "username", email: email, password: password, authtype: authtype, sessionkey: sessionkey)
            ProgressHUD.colorHUD = .lightGray
            ProgressHUD.showSucceed("Success !", delay: 0.75)
            // if login success hide above navigationbar(back button) -> set hide = true
            hide = true
            loginState.toggle()
        } else {
            loginFailState.toggle()
        }
    }
}

struct FocusStateBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
