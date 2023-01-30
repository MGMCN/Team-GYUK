//
//  registerView.swift
//  Client
//
//  Created by 高山 on 2023/1/26.
//

import SwiftUI

struct registerView: View {
    
    @State var username:String = ""
    @State var password:String = ""
    @State var confirmPassword:String = ""
    @State var email:String = ""
    
    @State var showPwd = false // This state indicates whether you want to see the plaintext password
    @State var showCPwd = false
    @State var back = false // This state indicates whether the back button was pressed
    
    
    //The outermost layer is a vertical layout, the first layout in the vertical direction is a horizontal layout, and the second layout in the vertical direction is a vertical layout. The first horizontal layout mainly puts a back button and a hint title.
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button(
                    action: {
                        self.back.toggle()
                    })
                {
                    Image(systemName:"arrow.backward.circle")
                        .foregroundColor(.white)
                        .font(.title3)
                }
                .padding()
                
                Spacer()
                
                Text("Create a new account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer(minLength:88)
            }
    
            VStack(alignment: .leading, spacing: 15) {
                HStack{
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.white)
                        .font(.title3)
                    Text("Username")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                TextField("Your username here..." ,text:$username)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(15)
                
                HStack{
                    Image(systemName: "envelope.circle.fill")
                        .foregroundColor(.white)
                        .font(.title3)
                    Text("Email")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                TextField("Your email here..." ,text:$email)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(15)
                
                HStack{
                    Image(systemName: "lock.circle.fill").foregroundColor(.white)
                        .font(.title3)
                    Text("Password")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                ZStack(alignment: .trailing){
                    if showPwd {
                        TextField("Your password here..." ,text:$password)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(15)
                    }else{
                        SecureField("Your password here..." ,text:$password)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                    Button(
                        action: {
                            self.showPwd.toggle()
                        })
                    {
                        Image(systemName: self.showPwd ?"eye" : "eye.slash")
                    }
                    .padding()
                }
                
                HStack{
                    Image(systemName: "lock.circle.fill").foregroundColor(.white)
                        .font(.title3)
                    Text("Confirm Password")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                ZStack(alignment: .trailing){
                    if showCPwd {
                        TextField("Your password here..." ,text:$confirmPassword)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(15)
                    }else{
                        SecureField("Your password here..." ,text:$confirmPassword)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                    Button(
                        action: {
                            self.showCPwd.toggle()
                        })
                    {
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
    
    var signUpButton: some View {
        Text("SIGN UP")
            .font(.headline)
            .foregroundColor(.blue)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 15)
//            .onTapGesture {
//                handleNextButtonPressed()
//            }
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView()
    }
}
