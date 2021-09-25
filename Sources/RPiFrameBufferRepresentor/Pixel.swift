//
//  Pixel.swift
//  フレームバッファの1ピクセルを扱う構造体
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation


/// struct handle one pixel of frame-buffer.
struct Pixel{
    
    let R: UInt8
    let G: UInt8
    let B: UInt8
    let A: UInt8
    
    /// initalize Pixel with color component.
    /// - Parameters:
    ///   - R: red component.
    ///   - G: green component.
    ///   - B: blue component.
    ///   - A: alpha component.
    init(R: UInt8, G: UInt8, B: UInt8, A: UInt8) {
        self.R = R
        self.G = G
        self.B = B
        self.A = A
    }
    
    
    /// initalize Pixel with Data.
    /// - Parameters:
    ///    - data: four-bytes long Data object. color-component order is A, B, G, R.
    init?(data: Data) {
        if data.count != 4 {
            return nil
        }
        
        let _data = data.reversed()
        self.init(R: _data[0], G: _data[1], B: _data[2], A: _data[3])
    }
}

