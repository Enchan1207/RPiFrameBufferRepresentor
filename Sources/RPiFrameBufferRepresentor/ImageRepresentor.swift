//
//  ImageRepresentor.swift
//  フレームバッファの画像表現を返す
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation
import CoreImage

class ImageRepresentor{
    
    /// convert FrameBuffer to CGImage.
    /// - Parameter from: convert target.
    /// - Returns: conversion result.
    static func convert(from buffer: FrameBuffer) -> CGImage? {
        
        // CGContext作って
        let dataPointer: UnsafeRawPointer = buffer.binary.bytes
        let colorSpace: CFString = CGColorSpace.sRGB
        let bitmapInfo: UInt32 = CGImageAlphaInfo.noneSkipFirst.rawValue | CGImageByteOrderInfo.order32Little.rawValue
        
        guard let cgContext: CGContext = .init(data: .init(mutating: dataPointer),
                                               width: Int(buffer.width), height: Int(buffer.height),
                                               bitsPerComponent: 8, bytesPerRow: Int(buffer.width * 4),
                                        space: .init(name: colorSpace)!,
                                             bitmapInfo: bitmapInfo) else {return nil}
        
        // 画像生成
        return cgContext.makeImage()
    }
    
}
