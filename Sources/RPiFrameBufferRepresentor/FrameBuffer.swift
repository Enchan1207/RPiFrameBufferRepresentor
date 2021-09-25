//
//  FrameBuffer.swift
//  フレームバッファを扱う構造体
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation

/// structure handling frame-buffer of Raspberry Pi.
struct FrameBuffer {
    let width: UInt
    let height: UInt
    
    let pixels: [Pixel]
    
    
    /// Initialize the FrameBuffer by specifying the width, height and pixels.
    /// NOTE: Initialization will fail if the number of pixels is not equal width × height.
    /// - Parameters:
    ///   - width: frame buffer width.
    ///   - height: frame buffer height.
    ///   - pixels: frame buffer pixels.
    init?(width: UInt, height: UInt, pixels: [Pixel]) {
        // ピクセル数と幅/高さが合わない場合は初期化に失敗する
        if pixels.count != width * height{
            return nil
        }
        
        self.width = width
        self.height = height
        self.pixels = pixels
    }
    
    /// Initialize the FrameBuffer by specifying the width and height. all pixels are filled with transparent.
    /// - Parameters:
    ///   - width: frame buffer width.
    ///   - height: frame buffer height.
    init(width: UInt, height: UInt) {
        let pixels: [Pixel] = (0..<(width*height)).map {_ in .init(R: 0, G: 0, B: 0, A: 0)}
        self.init(width: width, height: height, pixels: pixels)!
    }
}
