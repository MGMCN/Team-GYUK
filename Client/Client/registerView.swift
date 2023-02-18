//
//  registerView.swift
//  Client
//
//  Created by 高山 on 2023/1/26.
//

import Alamofire
import ProgressHUD
import SwiftUI

struct registerView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var signUpState = false
    @State var alertMessage = "Connection error !"

    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var email: String = ""

    @State var showPwd = false // This state indicates whether you want to see the plaintext password
    @State var showCPwd = false
    @State var back = false // This state indicates whether the back button was pressed

    // The outermost layer is a vertical layout, the first layout in the vertical direction is a horizontal layout, and the second layout in the vertical direction is a vertical layout. The first horizontal layout mainly puts a back button and a hint title.

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()

                    Text("Create a new account")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                        Text("Username")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    TextField("Your username here...", text: $username)
                        .font(.headline)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(15)
                        .foregroundColor(.black)

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
                        .font(.headline)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(15)
                        .foregroundColor(.black)

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
                                .font(.headline)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(.black)
                        } else {
                            SecureField("Your password here...", text: $password)
                                .font(.headline)
                                .frame(height: 55)
                                .padding(.horizontal)
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

                    HStack {
                        Image(systemName: "lock.circle.fill").foregroundColor(.white)
                            .font(.title3)
                        Text("Confirm Password")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    ZStack(alignment: .trailing) {
                        if showCPwd {
                            TextField("Your password here...", text: $confirmPassword)
                                .font(.headline)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(.black)
                        } else {
                            SecureField("Your password here...", text: $confirmPassword)
                                .font(.headline)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(15)
                                .foregroundColor(.black)
                        }
                        Button(
                            action: {
                                self.showCPwd.toggle()
                            }) {
                                Image(systemName: self.showCPwd ?"eye" : "eye.slash")
                            }
                            .padding()
                    }

                    Spacer()
                    signUpButton
                }
                .padding()
            }
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
            .alert(isPresented: $signUpState) {
                Alert(
                    title: Text("Register Information"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        alertMessage = "Connection error !"
                    }
                )
            }
            .padding([.bottom])
    }
}

extension registerView {
    func showRegisterSuccessOrNot() {
        if alertMessage == "Success !" {
            ProgressHUD.colorHUD = .lightGray
            ProgressHUD.showSucceed(alertMessage, delay: 0.75)
            presentationMode.wrappedValue.dismiss()
        } else {
            signUpState.toggle()
        }
    }

    func handleSignUpButtonPressed() {
        // Read input text message and send to server.
        if password != confirmPassword {
            alertMessage = "Password and confirm password do not match !"
            showRegisterSuccessOrNot()
        } else {
            let parameters = ["name": username, "email": email, "password": password, "authorityType": "1"]
            AF.request(urls.register_url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept": "application/json"]).responseJSON { response in
                if let data = response.data {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let code = jsonObject?["code"] as? Int {
                            if code == 1 {
                                alertMessage = "Success !"
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
                showRegisterSuccessOrNot()
            }
        }
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView()
    }
}
