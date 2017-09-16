//
//  ChineseConverter.swift
//  OpenCC
//
//  Created by Michael Row on 2017/9/13.
//  Copyright © 2017年 Michael Row. All rights reserved.
//

import Foundation
import OpenCCBridge.Private

public class ChineseConverter {
    
    private var opencc: opencc_t!
    
    public var convertOptions: ConvertOption = []
    
    private init() {}
    
    /// Initilize with the ConvertOption set. Simplize without any other option by default.
    ///
    /// Or you can Use Standardize/Simplize/Traditionalize struct to get the preset.
    public init?(_ options: ConvertOption) {
        convertOptions = options.standardize()
        
        let profile = configPath(for: options.configName)
        profile?.withCString { ptr in
            opencc = opencc_open(ptr)
        }
        
        // check whether opencc is valid.
        guard let invalidValue = UnsafeMutableRawPointer(bitPattern: -1),
              opencc != invalidValue
        else { return nil }
    }
    
    
    deinit {
        opencc_close(opencc)
    }
    
    
    private func configPath(for name: String) -> String? {
        return Bundle(identifier: "MR.OpenCC")?.path(forResource: name, ofType: "json")
    }
    
    
    /// Convert the input Chinese string using the selected options.
    ///
    /// - Parameter string: input Chinese string.
    /// - Returns: converted Chinese string.
    public func convert(string: String) -> String {
        let converted = string.withCString { ptr -> String in
            guard let cStringPtr = opencc_convert_utf8(opencc, ptr, Int(strlen(ptr))) else { return string }
            let converted = String(cString: cStringPtr)
            opencc_convert_utf8_free(cStringPtr)
            return converted
        }
        return converted
    }
}
