//
//  ImageFormatter.swift - CIImageからDataを生成
//  RPiFrameBufferRepresentor
//
//  Created by EnchantCode on 2021/02/11.
//
import Foundation
import CoreImage

class ImageFormatter {
    private let ciContext = CIContext()
    
    @available(OSX 10.13, *)
    func generatePNGImageData(image: CIImage, format:CIFormat = .RGBA8, colorSpace: CGColorSpace? = nil, options: [CIImageRepresentationOption: Any]? = nil) -> Data? {
        let ciContext = CIContext()
        return ciContext.pngRepresentation(of: image, format: format, colorSpace: image.colorSpace!, options: options ?? [:])
    }
    
    @available(OSX 10.12, *)
    func generateJPEGImageData(image: CIImage, format:CIFormat = .RGBA8, colorSpace: CGColorSpace? = nil, options: [CIImageRepresentationOption: Any]? = nil) -> Data? {
        let ciContext = CIContext()
        return ciContext.jpegRepresentation(of: image, colorSpace: image.colorSpace!, options: options ?? [:])
    }

}
