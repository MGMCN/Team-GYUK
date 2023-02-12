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
    
    @StateObject var viewModel: EnvironmentViewModel = .init()

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            NavigationView {
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
                    
                    ZStack {
                        Color.blue.edgesIgnoringSafeArea(.all)
                        List {
                            ForEach(viewModel.dataArray, id: \.self) { item in
                                HStack {
                                    Image(systemName: "gear")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                    NavigationLink(
                                        destination: DetailView(selectedItem: item),
                                        label: {
                                            Text(item)
                                        }
                                    )
                                    .padding(.vertical)
                                }
                            }
                        }
                        .fontWeight(.semibold)
                        .shadow(radius: 15)
                    }
                    .cornerRadius(30)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .background(.blue)
                    
                }
                .background(.blue)
            }
            .environmentObject(viewModel)
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(
//                leading:
//                    Button(action: {
//                        self.hide = false
//                        self.presentationMode.wrappedValue.dismiss()
//                    }, label: {
//                        Image(systemName: "arrow.backward.circle")
//                            .foregroundColor(.white)
//                            .font(.title3)
//                    })
//            )
            
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
        .background(.blue)
    }
}

struct DetailView: View {
    let selectedItem: String

    var body: some View {
        ZStack {
            // background
            Color.orange.ignoresSafeArea()

            // foreground
            NavigationLink(
                destination: FinalView(),
                label: {
                    Text(selectedItem)
                        .font(.headline)
                        .foregroundColor(.orange)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(30)
                }
            )
        }
    }
}

struct FinalView: View {
    @EnvironmentObject var viewModel: EnvironmentViewModel

    var body: some View {
            ZStack {
                // background
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // foreground
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.dataArray, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                }
            }
    }
}

struct EnvironmentObjectBootcamp_Previews: PreviewProvider {
    @State static var hide = false // only for test
    static var previews: some View {
        operationView(hide:$hide)
    }
}
