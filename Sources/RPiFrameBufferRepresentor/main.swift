//
//  main.swift
//  entry-point
//
//  Created by EnchantCode on 2021/02/11.
//

import Foundation
import CoreImage
import ArgumentParser

struct fbconv: ParsableCommand {
    
    @Argument(help: "input file path. NOTE: Please DO NOT specify /dev/fb0 directly.", completion: .file())
    var input: String
    
    @Option(name: .shortAndLong, help: "output directory path.")
    var output: String?
    
    @Option(name: .shortAndLong, help: "The width of screen.")
    var width: UInt?
    
    @Option(name: .shortAndLong, help: "The height of screen.")
    var height: UInt?
    
    mutating func run() throws {
        
        // 幅または高さのいずれも設定されていなければreturn
        if width == nil && height == nil {
            throw ValidationError("Please specify width or height.")
        }
        
        let manager: FileManager = .default
        
        // 入力ファイル読み込み
        if !manager.isReadableFile(atPath: input){
            throw ApplicationError.FileInAccessible(path: input)
        }
        
        guard let binary: Data = manager.contents(atPath: input) else{
            throw ApplicationError.FileNotFound(path: input)
        }
        let pixelCount: UInt = .init(binary.count / 4)
        
        // 画面の幅と高さを自動計算
        let _width: UInt = (height == nil) ? width! : (pixelCount / height!)
        let _height: UInt = (width == nil) ? height! : (pixelCount / width!)
        
        // 幅*高さとピクセル数が合わなければエラー
        if _width * _height != pixelCount {
            throw ValidationError("width or height value is invalid. remove one of those to re-calculation.")
        }
        
        print("FrameBuffer: \(_width) × \(_height)")
        
        // フレームバッファ生成
        guard let frameBuffer: FrameBuffer = .init(width: _width, height: _height, binary: .init(data: binary)) else {
            throw ValidationError("Couldn't instantiate FrameBuffer.")
        }
        
        // 画像に変換
        guard let cgImage = ImageRepresentor.convert(from: frameBuffer) else {
            throw ApplicationError.ImageConversionFailed
        }
        
        // 入力先から出力先を設定
        let _output = output ?? manager.currentDirectoryPath
        let inputURL = URL(fileURLWithPath: input)
        let inputFileName = inputURL.lastPathComponent
        let inputFileSuffix = inputURL.pathExtension
        let outputFileName = inputFileName.replacingOccurrences(of: inputFileSuffix, with: "png")
        let outputFilePath = URL(fileURLWithPath: _output)
            .appendingPathComponent(outputFileName)
            .path
        
        print("Converted file will be output \(outputFilePath)")
        
        // PNG形式で保存
        let pngRepresentation = ImageFormatter().generatePNGImageData(image: .init(cgImage: cgImage))
        
        if !manager.createFile(atPath: outputFilePath, contents: pngRepresentation, attributes: nil){
            throw ApplicationError.ImageSaveFailed
        }
    }
    
}

fbconv.main()
