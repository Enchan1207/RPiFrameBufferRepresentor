//
//  FrameBuffer.swift
//  フレームバッファを扱う構造体
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation

/// structure handling frame-buffer of Raspberry Pi.
struct FrameBuffer: CustomStringConvertible {
    
    let width: UInt
    let height: UInt
    
    let binary: NSData
    
    
    /// Initialize the FrameBuffer by specifying the width, height and pixels.
    /// NOTE: Initialization will fail if the number of pixels is not equal width × height.
    /// - Parameters:
    ///   - width: frame buffer width.
    ///   - height: frame buffer height.
    ///   - pixels: frame buffer pixels.
    init?(width: UInt, height: UInt, binary: NSData) {
        // ピクセル数と幅/高さが合わない場合は初期化に失敗する
        if binary.count != width * height * 4{
            return nil
        }
        
        self.width = width
        self.height = height
        self.binary = binary
    }
    
    /// Initialize the FrameBuffer by specifying the width and height. all pixels are filled with transparent.
    /// - Parameters:
    ///   - width: frame buffer width.
    ///   - height: frame buffer height.
    init(width: UInt, height: UInt) {
        let binary: NSData = .init(data: .init(count: Int(width * height) * 4))
        self.init(width: width, height: height, binary: binary)!
    }
    
    var description: String {
        get{
            return "FrameBuffer(width: \(width), height: \(height))"
        }
    }
}
