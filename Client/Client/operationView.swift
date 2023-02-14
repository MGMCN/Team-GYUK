//
//  operationView.swift
//  Client
//
//  Created by Yamaoka and GAO SHAN on 2023/01/26.
//

import Foundation
import SwiftUI

// ObservedObject
// StateObject
// EnvironmentObject

class EnvironmentViewModel: ObservableObject {
    @Published var dataArray: [String] = []

    init() {
        getData()
    }

    func getData() {
        dataArray.append(contentsOf: ["Add", "Delete", "Borrow", "Return"])
    }
}

struct operationView: View {
    @Binding var hide: Bool

    @State var showBooksState = false
    
    @StateObject var viewModel: EnvironmentViewModel = .init()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
        VStack {
                VStack {
                    HStack {
                        Text("Operation Menu")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Image(systemName: "books.vertical.fill")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Spacer()

                    }.padding()

                    VStack{
                        HStack{
                            Button(
                                action: {
                                    
                                }) {
                                    VStack(alignment: .leading,spacing: 0){
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .padding([.top, .trailing])
                                        Text("Add bk")
                                            .foregroundColor(.white)
                                            .font(.title3)
//                                            .fontWeight(.semibold)
                                            .shadow(radius: 15)
                                            .padding([.top, .bottom, .trailing])
                                    }
                                    
                                }
                                .frame(width: 100, height: 73)
                                .buttonBorderShape(.capsule)
                                .background(Color(hue: 0.588, saturation: 0.564, brightness: 0.973, opacity: 0.9))
                                .cornerRadius(10)
                                .shadow(radius: 15)
                                .padding(.vertical)
                            
                            Button(
                                action: {
                                    
                                }) {
                                    VStack(alignment: .leading,spacing: 0){
                                        Image(systemName: "trash.circle")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .padding([.top, .trailing])
                                        Text("Delete")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .shadow(radius: 15)
                                            .padding([.top, .bottom, .trailing])
                                    }
                                    
                                }
                                .frame(width: 100, height: 73)
                                .buttonBorderShape(.capsule)
                                .background(Color(hue: 0.588, saturation: 0.564, brightness: 0.973, opacity: 0.9))
                                .cornerRadius(10)
                                .shadow(radius: 15)
//                                .padding()
                            
                            Button(
                                action: {
                                    
                                }) {
                                    VStack(alignment: .leading,spacing: 0){
                                        Image(systemName: "qrcode.viewfinder")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .padding([.top, .trailing])
                                        Text("Borrow")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .shadow(radius: 15)
                                            .padding([.top, .bottom, .trailing])
                                    }
                                    
                                }
                                .frame(width: 100, height: 73)
                                .buttonBorderShape(.capsule)
                                .background(Color(hue: 0.588, saturation: 0.564, brightness: 0.973, opacity: 0.9))
                                .cornerRadius(10)
                                .shadow(radius: 15)
                                .padding(.vertical)
                        }
                        .padding(.top)
                        
                        HStack{
                            Button(
                                action: {
                                    
                                }) {
                                    VStack(alignment: .leading,spacing: 0){
                                        Image(systemName: "arrow.left.arrow.right.circle")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .padding([.top, .trailing])
                                        Text("Return")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .shadow(radius: 15)
                                            .padding([.top, .bottom, .trailing])
                                    }
                                    
                                }
                                .frame(width: 100, height: 73)
                                .buttonBorderShape(.capsule)
                                .background(Color(hue: 0.588, saturation: 0.564, brightness: 0.973, opacity: 0.9))
                                .cornerRadius(10)
                                .shadow(radius: 15)
                            
                            Button(
                                action: {
                                    handleShowBooksButtonPressed()
                                }) {
                                    VStack(alignment: .leading,spacing: 0){
                                        Image(systemName: "books.vertical.circle")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .padding([.top, .trailing])
                                        Text("Books")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .shadow(radius: 15)
                                            .padding([.top, .bottom, .trailing])
                                    }
                                    
                                }
                                .frame(width: 100, height: 73)
                                .buttonBorderShape(.capsule)
                                .background(Color(hue: 0.588, saturation: 0.564, brightness: 0.973, opacity: 0.9))
                                .cornerRadius(10)
                                .shadow(radius: 15)
                            
                            Button(
                                action: {
                                    
                                }) {
                                    EmptyView()
                                }
                                .frame(width: 100, height: 73)
//                                .buttonBorderShape(.capsule)
//                                .background(Color(hue: 0.588, saturation: 0.564, brightness: 0.973, opacity: 0.9))
//                                .cornerRadius(10)
//                                .shadow(radius: 15)
                        }
                        
                        NavigationLink(destination: bookDisplayView(),
                                       isActive: $showBooksState) {
                            EmptyView()
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.hide = false
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "door.right.hand.open")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                            Text("Sign out")
                                .foregroundColor(.white)
                                .font(.title2)
                        })
                        
                    }
                    .frame(maxHeight: .infinity)
                }
                .background(.blue)
            }
            .environmentObject(viewModel)
        }
        .background(.blue)
    }
}

extension operationView {
    func handleShowBooksButtonPressed(){
        showBooksState.toggle()
    }
}

struct Previews_operationView_Previews: PreviewProvider {
    @State static var hide = false
    static var previews: some View {
        operationView(hide: $hide)
    }
}
