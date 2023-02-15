//
//  ContentView.swift
//  Demo
//
//  Created by GS on 2023/2/15.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var message = "hello world!"
    var body: some View {
        VStack{
            Text(message)
                .padding()
            VStack {
                Button(
                    action: {
                        handleGet()
                    }) {
                        Text("Get")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background(.blue)
                    .buttonBorderShape(.capsule)
                    .cornerRadius(15)
                Button(
                    action: {
                        handlePost()
                    }) {
                        Text("Post")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background(.blue)
                    .buttonBorderShape(.capsule)
                    .cornerRadius(15)
            }
            .padding()
        }
    }
}

extension ContentView {
    func handleGet(){
        AF.request("https://httpbin.org/get").response { response in
            message = response.debugDescription
        }
    }
    
    func handlePost(){
        let parameters = ["hello ": "world!"]
        AF.request("https://httpbin.org/post", method: .post, parameters: parameters).response { response in
            message = response.debugDescription
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
