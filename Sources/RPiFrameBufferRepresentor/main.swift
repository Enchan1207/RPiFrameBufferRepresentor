//
//  main.swift
//  entry-point
//
//  Created by EnchantCode on 2021/02/11.
//

import Foundation
import CoreImage

let arguments = CommandLine.arguments
DispatchQueue.global().async {
    let result = RPiFrameBufferRepresentor().main(arguments: arguments)
    exit(result)
}

dispatchMain()
