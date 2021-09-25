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
    ///    - data: four-bytes long Data object. color-component order is R, G, B, A
    init?(data: Data) {
        if data.count != 4 {
            return nil
        }
        
        self.init(R: data[0], G: data[1], B: data[2], A: data[3])
    }
    
    /// return CGColor representation.
    var colorRepresentation: CGColor {
        get{
            let ratio = {(c: UInt8) -> CGFloat in CGFloat(c) / 255.0}
            return .init(red: ratio(R), green: ratio(G), blue: ratio(B), alpha: ratio(A))
        }
    }
}

