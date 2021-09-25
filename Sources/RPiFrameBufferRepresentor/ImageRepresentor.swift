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
        guard let cgContext: CGContext = .init(data: nil, width: Int(buffer.width), height: Int(buffer.height), bitsPerComponent: 8, bytesPerRow: Int(buffer.width) * 4, space: .init(name: CGColorSpace.sRGB)!, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else {return nil}
        
        // ピクセルをContextに配置していく
        for x in 0..<buffer.width{
            for y in 0..<buffer.height{
                let x_ = Int(x)
                let y_ = Int(buffer.height - 1 - y) // 座標系の吸収(AppKitは左下が0, 0 )
                
                let pos: Int = Int(y * buffer.width + x)
                let pixel = buffer.pixels[pos]
                
                cgContext.setFillColor(pixel.colorRepresentation)
                cgContext.fill(.init(x: x_, y: y_, width: 1, height: 1))
            }
        }
        
        guard let cgImage = cgContext.makeImage() else {return nil}
        return cgImage
    }
    
}
