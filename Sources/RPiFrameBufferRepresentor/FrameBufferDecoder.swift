//
//  FrameBufferDecoder.swift
//  フレームバッファデコーダ
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation

class FrameBufferDecoder{
    
    /// Decode Data to FrameBuffer.
    /// - Parameters:
    ///    - from: decode-target data.
    ///    - width: frame buffer width.
    ///    - height: frame buffer height.
    /// - Returns: If decoding process finished succrssfully, return FrameBuffer.
    static func decode(from: Data, width: UInt, height: UInt) -> FrameBuffer? {
        
        // 4bit(RGBAのLE)ずつスライス
        let binaryLength = from.count
        let splitRange = 0..<(binaryLength / 4)
        
        let splitBinaries = splitRange.map { offset -> Data in
            let start = from.startIndex.advanced(by: offset * 4)
            let end = start.advanced(by: 4)
            return from.subdata(in: start..<end)
        }
        
        // pixel配列を生成し
        let pixels: [Pixel] = splitBinaries.map {.init(data: $0)!}
        
        return .init(width: width, height: height, pixels: pixels)
    }
    
    
}
