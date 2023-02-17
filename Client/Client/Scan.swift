//
//  Scan.swift
//  Client
//
//  Created by yamaoka on 2023/02/09.
//

import AVFoundation
import Foundation
import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context _: Context) -> some UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        return controller
    }

    func updateUIViewController(_: UIViewControllerType, context _: Context) {}
}
