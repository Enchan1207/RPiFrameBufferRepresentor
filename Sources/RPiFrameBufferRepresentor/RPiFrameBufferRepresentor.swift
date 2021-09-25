//
//  RPiFrameBufferRepresentor.swift
//  RPiFrameBufferRepresentor
//
//  Created by EnchantCode on 2021/09/25.
//

import Foundation
import AppKit

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
        
        // 今のところは一枚だけ処理して終わり
        guard let path = screenshotPaths.first else {return 1}
        
        // バイナリを取得し
        guard let binary = try? Data(contentsOf: .init(fileURLWithPath: path)) else {return 1}
        
        // バッファを生成
        let width: UInt = 1920
        let height: UInt = 1088
        
        guard let frameBuffer = FrameBufferDecoder.decode(from: binary, width: width, height: height) else {return 1}
        
        print(frameBuffer)
        
        return 0
    }
    
}
