//
//  ImageExtension.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

// Ref: https://stackoverflow.com/questions/63651077/how-to-center-crop-an-image-in-swiftui
// Function to horizontally crop image to device, vertically crop to device, while keeping image ratio

import SwiftUI
import Foundation

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

