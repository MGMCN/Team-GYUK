//
//  qrCodeScanView.swift
//  Client
//
//  Created by GS on 2023/2/17.
//

import CodeScanner
import SwiftUI

// for test

struct qrCodeScanView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let code = scannedCode {
                    NavigationLink("To next", destination: homeView(), isActive: .constant(true)).hidden()
                }

                Button("Scan Code") {
                    isPresentingScanner = true
                }

                Text("Scan a QR code to begin")
            }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr]) { response in
                    if case let .success(result) = response {
                        scannedCode = result.string
                        isPresentingScanner = false
                    }
                }
            }
        }
    }
}

struct qrCodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        qrCodeScanView()
    }
}
