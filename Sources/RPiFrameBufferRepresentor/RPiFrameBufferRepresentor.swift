//
//  RPiFrameBufferRepresentor.swift
//  RPiFrameBufferRepresentor
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation

final class RPiFrameBufferRepresentor{
    
    final func main(arguments: [String]) -> Int32 {
        
        // マネージャ経由でファイルを読み出す
        let fileManager: FileManager = .default
        
        // ~/Desktop/fb_screenshots に移動
        let screenshotsDirectory: String = "~/Desktop/fb_screenshots"
        assert(fileManager.changeCurrentDirectoryPath(screenshotsDirectory.replacingOccurrences(of: "~", with: NSHomeDirectory())))
        
        // ファイル一覧を取得し、
        guard let files: [String] = try? fileManager.contentsOfDirectory(atPath: fileManager.currentDirectoryPath) else {return 1}
        
        // *.binを取り出す
        let screenshotPaths = files.filter {$0.hasSuffix(".bin")}
        
        // MARK: - 書き散らしてるだけのテスト実装
        guard let path = screenshotPaths.first else {return 1}
        
        // バイナリを取得
        guard let binary = try? Data(contentsOf: .init(fileURLWithPath: path)) else {return 1}
        
        struct Pixel{
            let R: UInt8
            let G: UInt8
            let B: UInt8
            let A: UInt8
            
            init(R: UInt8, G: UInt8, B: UInt8, A: UInt8) {
                self.R = R
                self.G = G
                self.B = B
                self.A = A
            }
            
            init?(data: Data) {
                if data.count != 4 {
                    return nil
                }
                
                self.init(R: data[0], G: data[1], B: data[2], A: data[3])
            }
        }
        
        // 4bit(RGBAのLE)ずつスライス
        let binaryLength = binary.count
        let splitRange = 0..<(binaryLength / 4)
        
        let splitBinaries = splitRange.map { offset -> Data in
            let start = binary.startIndex.advanced(by: offset * 4)
            let end = start.advanced(by: 4)
            return binary.subdata(in: start..<end)
        }
        let pixels: [Pixel] = splitBinaries.map {.init(data: $0)!}
        
        
        return 0
    }
    
}
