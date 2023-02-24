//
//  operationView.swift
//  Client
//
//  Created by Yamaoka and GAO SHAN on 2023/01/26.
//

import CodeScanner
import Foundation
import SwiftUI
import ProgressHUD
import Alamofire

struct operationView: View {
    @Binding var hide: Bool
    @Binding var email: String
    @Binding var password: String

    @State var showBooksState = false

    @State var openCameraState = false
    
    @State var doOperationState = false

    @State var operationState = "operationState"

    @State var bookName = "bookName"
    
    @State var alertMessage = "alertMessage"
    
    @State var books = [String]()
    
    @State var bookStates = [String]()

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

                        if account.authtype == 0 {
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
                                
                                Button(
                                    action: {})
                                {
                                    EmptyView()
                                }
                                .frame(width: 100, height: 73)
                            }
                        }

                        NavigationLink(destination: bookDisplayView(books: books, bookStates: bookStates),
                                       isActive: $showBooksState) {
                            EmptyView()
                        }

                        Spacer()

                        Button(action: {
                            handleSignOutButtonPressed()
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
                .alert(isPresented: $doOperationState) {
                    Alert(
                        title: Text("Operation Information"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK")) {
                        }
                    )
                }
                .background(.blue)
                .sheet(isPresented: $openCameraState) {
                    CodeScannerView(codeTypes: [.qr], scanMode: .once, showViewfinder: true) { response in
                        if case let .success(result) = response {
                            bookName = result.string
                            openCameraState = false
                            // check operationState and use AF to request
                            doOperation()
                        }
                    }
                    .background(.blue)
                }
            }
        }
    }
}

extension operationView {
    
    func showSuccessProgressHUD() {
        ProgressHUD.colorHUD = .lightGray
        ProgressHUD.showSucceed("Success !", delay: 0.75)
    }
    
    func doRequest(url: String){
        let parameters = ["session_key": account.sessionkey, "bookName": bookName]
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept": "application/json"]).responseJSON { response in
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
            showOperationSuccessOrNot()
        }
    }
    
    func doGetBookList(){
        AF.request(urls.showbooks_url, method: .get, encoding: URLEncoding.default, headers: ["Accept": "application/json"]).responseJSON { response in
            if let data = response.data {
                do {
                    books.removeAll()
                    bookStates.removeAll()
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                            // jsonArray contains an array of dictionaries, each representing an object
                            for dictionary in jsonArray {
                                if let bookname = dictionary["bookName"] as? String, let bookstatus = dictionary["bookStatus"] as? String {
                                    books.append(bookname+"   ("+bookstatus+")")
                                    bookStates.append(bookstatus)
                                }
                            }
                        }
                    showBooksState.toggle()
                    } catch {
                        alertMessage = "Error parsing JSON: \(error.localizedDescription)"
                        doOperationState.toggle()
                    }
            }
        }
    }
    
    func showOperationSuccessOrNot(){
        if alertMessage == "Success !"{
            showSuccessProgressHUD()
        }else{
            doOperationState.toggle()
        }
    }
    
    func doOperation() {
        switch operationState {
        case "show":
            return
        case "borrow":
            doRequest(url: urls.borrowbook_url)
            return
        case "delete":
            doRequest(url: urls.deletebook_url)
            return
        case "add":
            doRequest(url: urls.addbook_url)
            return
        case "return":
            doRequest(url: urls.returnbook_url)
            return
        default:
            return
        }
    }

    func handleShowBooksButtonPressed() {
        operationState = "show"
        doGetBookList()
    }

    func handleBorrowButtonPressed() {
        operationState = "borrow"
        openCameraState.toggle()
    }

    func handleDeleteButtonPressed() {
        operationState = "delete"
        openCameraState.toggle()
    }

    func handleAddBookButtonPressed() {
        operationState = "add"
        openCameraState.toggle()
    }

    func handleReturnButtonPressed() {
        operationState = "return"
        openCameraState.toggle()
    }
    
    func handleSignOutButtonPressed(){
        // request logout
        let parameters = ["session_key": account.sessionkey]
        AF.request(urls.logout_url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept": "application/json"]).responseJSON { response in
            if let data = response.data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let code = jsonObject?["code"] as? Int {
                        if code == 1 {
                            self.hide = false
                            self.email = ""
                            self.password = ""
                            account.reset()
                            showSuccessProgressHUD()
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            //
                        }
                    }
                } catch {
                    //
                }
            }
        }
    }
}

struct Previews_operationView_Previews: PreviewProvider {
    @State static var hide = false
    @State static var email = ""
    @State static var password = ""
    static var previews: some View {
        operationView(hide: $hide, email: $email, password: $password)
    }
}
