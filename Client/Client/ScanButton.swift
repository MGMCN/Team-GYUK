//
//  ScanButton.swift
//  Client
//
//  Created by yamaoka on 2023/02/09.
//

import Foundation
import SwiftUI

struct ScanButtonView: View {
    @State var showingCamera = false
    //本を追加、削除、借りる、返すの状態を保持
    @State var operation = ""
    
    var body: some View {
        Button(action:{
            showingCamera = true
        }){
            Text("カメラを起動する")
        }
        .sheet(isPresented: $showingCamera, content: {
            CameraView()
        })
    }
}
//テスト用手入力のビュー
struct TextView: View {
    @State private var name = ""
    var body: some View {
        TextField("本のタイトルを入力してください", text: $name)
            .padding()
    }
}
struct ScanButtonView_Previews: PreviewProvider {
    static var previews: some View {
//        TextView()
        ScanButtonView()
    }
}
