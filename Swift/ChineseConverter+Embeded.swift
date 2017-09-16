//
//  ChineseConverter+Embeded.swift
//  OpenCC
//
//  Created by Michael Row on 2017/9/15.
//  Copyright © 2017年 Michael Row. All rights reserved.
//

import Foundation

extension ChineseConverter {
    
    public struct ConvertOption: OptionSet {
        
        public let rawValue: UInt
        
        public init(rawValue: UInt) { self.rawValue = rawValue }
        
        /// A option to simplify the input Chinese characters.
        /// - warning: `simplize` and `traditionalize` are mutually exclusive.
        public static let simplize = ConvertOption(rawValue: 1 << 0)
        
        /// A option to traditionalize the input Chinese characters.
        /// - warning: `simplize` and `traditionalize` are mutually exclusive.
        public static let traditionalize = ConvertOption(rawValue: 1 << 1)
        
        /// Convert the Chinese characters alone with localize phrase.
        public static let withPhrase = ConvertOption(rawValue: 1 << 2)
        
        /// Use Taiwan locale.
        /// - warning: `taiwanStandard` and `hkStandard` are mutually exclusive.
        public static let taiwanStandard = ConvertOption(rawValue: 1 << 10)
        
        /// Use HK locale.
        /// - warning: `taiwanStandard` and `hkStandard` are mutually exclusive.
        public static let hkStandard = ConvertOption(rawValue: 1 << 11)
        
        func standardize() -> ConvertOption {
            var newOption = self
            
            if self.contains([.simplize, .traditionalize]) {
                newOption.remove(.traditionalize)
            }
            
            if self.contains([.taiwanStandard, .hkStandard]) {
                newOption.remove(.hkStandard)
            }
            
            return newOption
        }
        
        var configName: String {
            switch self.standardize() {
            case []:
                return "t2s"
            case [.traditionalize]:
                return "s2t"
            case [.traditionalize, .taiwanStandard]:
                return "s2tw"
            case [.traditionalize, .taiwanStandard, .withPhrase]:
                return "s2twp"
            case [.traditionalize, .hkStandard]:
                return "s2hk"
            case [.traditionalize, .hkStandard, .withPhrase]:
                return "s2hk"
            case [.simplize]:
                return "t2s"
            case [.simplize, .taiwanStandard]:
                return "tw2s"
            case [.simplize, .taiwanStandard, .withPhrase]:
                return "tw2sp"
            case [.simplize, .hkStandard]:
                return "hk2s"
            case [.simplize, .hkStandard, .withPhrase]:
                return "hk2s"
            case [.hkStandard]:
                return "t2hk"
            case [.taiwanStandard]:
                return "t2tw"
            default:
                return "t2s"
            }
        }
    }
}

public struct Standardize {
    
    public static let taiwanStandard: ChineseConverter.ConvertOption = [.taiwanStandard]
    
    public static let hkStandard: ChineseConverter.ConvertOption = [.hkStandard]
    
    private init() {}
}

public struct Simplize {
    
    /// Default simplize without HK and Taiwan localization.
    public static let `default`: ChineseConverter.ConvertOption = [.simplize]
    
    /// Simplify Taiwan traditional Chinese characters only.
    public static let taiwanStandard: ChineseConverter.ConvertOption = [.simplize, .taiwanStandard]
    
    /// Simplify HK traditional Chinese characters only.
    public static let hkStandard: ChineseConverter.ConvertOption = [.simplize, .hkStandard]
    
    /// Simplify Taiwan traditional Chinese characters alone with localize phrase.
    public static let taiwanPhrase: ChineseConverter.ConvertOption = [.simplize, .taiwanStandard, .withPhrase]
    
    private init() {}
}

public struct Traditionalize {
    
    public static let `default`: ChineseConverter.ConvertOption = [.traditionalize]
    
    public static let taiwanStandard: ChineseConverter.ConvertOption = [.traditionalize, .taiwanStandard]
    
    public static let hkStandard: ChineseConverter.ConvertOption = [.traditionalize, .hkStandard]
    
    public static let taiwanPhrase: ChineseConverter.ConvertOption = [.traditionalize, .taiwanStandard, .withPhrase]
    
    private init() {}
}
