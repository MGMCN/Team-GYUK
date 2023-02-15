//
//  ContentView.swift
//  ProgressBarDemo
//
//  Created by 高山 on 2023/2/15.
//

import SwiftUI
import ProgressHUD

struct ContentView: View {
    
    var body: some View {
                VStack {
                    Text("press me")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(height: 55)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 15)
                        .onTapGesture {
//                            ProgressHUD.colorHUD = .lightGray // default
                            ProgressHUD.showSucceed()
//                            ProgressHUD.showSucceed("success", delay: 1.0)
//                            ProgressHUD.showFailed()
//                            ProgressHUD.dismiss() // see document
//                            ProgressHUD.remove()
                        }
                }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
