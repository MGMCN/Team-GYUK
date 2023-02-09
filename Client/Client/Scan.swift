//
//  Scan.swift
//  Client
//
//  Created by yamaoka on 2023/02/09.
//

import Foundation
import UIKit
import AVFoundation
import SwiftUI

struct CameraView:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        return controller;
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
