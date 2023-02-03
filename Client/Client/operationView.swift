//
//  select.swift
//  Client
//
//  Created by GAO SHAN on 2023/01/26.
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
        self.dataArray.append(contentsOf: ["add", "delete", "borrow", "return"])
    }
    
    
}

struct EnvironmentObjectBootcamp: View {
    
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.blue.edgesIgnoringSafeArea(.all)
                List {
                    ForEach(viewModel.dataArray, id: \.self) { item in
                        NavigationLink(
                            destination: DetailView(selectedItem: item),
                            label: {
                                Text(item)
                            })
                        
                    }
                }
                .navigationTitle("Book Menu")
                
                
            }
            .cornerRadius(30)
            .padding()
            .scrollContentBackground(.hidden)
            .background(.blue)
//            .shadow(radius: 100)
        }
        .environmentObject(viewModel)
        
    }
}

struct DetailView: View {
    
    let selectedItem: String
    
    var body: some View {
        ZStack {
            // background
            Color.orange.ignoresSafeArea()
            
            //foreground
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
                })
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
                endPoint: .bottomTrailing)
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
//    .background(Color.blue)
}

struct EnvironmentObjectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectBootcamp()
        //DetailView(selectedItem: "iPhone")
        //FinalView()
    }
}
