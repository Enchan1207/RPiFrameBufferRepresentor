//
//  ImageDrawer.swift
//  画像処理
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation
import CoreImage
import CoreGraphics

class ImageDrawer {
    
    private static let ciContext = CIContext()
    private let cgContext: CGContext?
    private let cgImage: CGImage
    
    init(cgImage: CGImage){
        self.cgImage = cgImage
        self.cgContext = Self.generateCGContext(cgImage: cgImage)
    }
    
    convenience init?(ciImage: CIImage) {
        guard let cgImage = Self.ciContext.createCGImage(ciImage, from: ciImage.extent) else{return nil}
        self.init(cgImage: cgImage)
    }
    
    // CGContext生成
    internal static func generateCGContext(cgImage: CGImage) -> CGContext?{
        guard let cgContext = CGContext(
            data: nil,
            width: cgImage.width,
            height: cgImage.height,
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: cgImage.bytesPerRow,
            space: cgImage.colorSpace!,
            bitmapInfo: cgImage.bitmapInfo.rawValue
        )else{return nil}
        
        return cgContext
    }
    
    // contextに任意の処理を加える
    func apply(process: (_ context:CGContext) -> Void){
        if let cgContext = self.cgContext{
            process(cgContext)
        }
    }
    
    // 現在のContextからCGImageを生成
    func generateImageFromContext() -> CGImage?{
        return self.cgContext?.makeImage()
    }
    
}
