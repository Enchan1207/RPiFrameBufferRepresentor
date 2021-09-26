//
//  errors.swift
//  
//
//  Created by EnchantCode on 2021/09/26.
//

import Foundation

enum ApplicationError: LocalizedError {
    case FileNotFound(path: String)
    case FileInAccessible(path: String)
    case ImageConversionFailed
    case ImageSaveFailed
    
    var errorDescription: String? {
        switch self {
        case let .FileNotFound(path):
            return "\(path) not found."
        case let .FileInAccessible(path):
            return "\(path) couldn't access."
        case .ImageConversionFailed:
            return "image conversion failed."
        case .ImageSaveFailed:
            return "image save failed."
            
        }
    }
}
