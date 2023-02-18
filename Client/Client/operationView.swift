//
//  operationView.swift
//  Client
//
//  Created by Yamaoka and GAO SHAN on 2023/01/26.
//

import CodeScanner
import Foundation
import SwiftUI

// ObservedObject
// StateObject
// EnvironmentObject

// class EnvironmentViewModel: ObservableObject {
//    @Published var dataArray: [String] = []
//
//    init() {
//        getData()
//    }
//
//    func getData() {
//        dataArray.append(contentsOf: ["Add", "Delete", "Borrow", "Return"])
//    }
// }

struct operationView: View {
    @Binding var hide: Bool

    @State var showBooksState = false

    @State var openCameraState = false

    @State var operationState = "state"

    @State var bookName = "None"

//    @StateObject var viewModel: EnvironmentViewModel = .init()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Text("Operation Menu")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        Spacer()

                    }.padding()

                    VStack {
                        HStack {
                            Button(
                                action: {
                                    handleBorrowButtonPressed()
                                }) {
                                    VStack(alignment: .leading, spacing: 0) {
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

                            Button(
                                action: {
                                    handleReturnButtonPressed()
                                }) {
                                    VStack(alignment: .leading, spacing: 0) {
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
                                    VStack(alignment: .leading, spacing: 0) {
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
                        }
                        .padding(.top)

                        HStack {
                            Button(
                                action: {
                                    handleAddBookButtonPressed()
                                }) {
                                    VStack(alignment: .leading, spacing: 0) {
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
                                    handleDeleteButtonPressed()
                                }) {
                                    VStack(alignment: .leading, spacing: 0) {
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
                                action: {})
                            {
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
                                .font(.title2)
                                .padding([.bottom])
                            Text("Sign out")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding([.bottom, .trailing])
                        })
                    }
                    .frame(maxHeight: .infinity)
                }
                .background(.blue)
                .sheet(isPresented: $openCameraState) {
                    CodeScannerView(codeTypes: [.qr]) { response in
                        if case let .success(result) = response {
                            bookName = result.string
                            openCameraState = false
                            // check operationState and use AF to request
                            print(bookName)
                        }
                    }
                    .background(.blue)
                }
            }
        }
//        .background(.blue)
    }
}

extension operationView {
    func doOperation() {
        switch operationState {
        case "show":
            showBooksState.toggle()
        default:
            openCameraState.toggle()
        }
    }

    func handleShowBooksButtonPressed() {
        operationState = "show"
        doOperation()
    }

    func handleBorrowButtonPressed() {
        operationState = "borrow"
        doOperation()
    }

    func handleDeleteButtonPressed() {
        operationState = "delete"
        doOperation()
    }

    func handleAddBookButtonPressed() {
        operationState = "add"
        doOperation()
    }

    func handleReturnButtonPressed() {
        operationState = "return"
        doOperation()
    }
}

struct Previews_operationView_Previews: PreviewProvider {
    @State static var hide = false
    static var previews: some View {
        operationView(hide: $hide)
    }
}
