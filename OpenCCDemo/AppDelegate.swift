//
//  AppDelegate.swift
//  OpenCCDemo
//
//  Created by Michael Row on 2017/9/16.
//  Copyright © 2017年 Michael Row. All rights reserved.
//

import Cocoa
import OpenCCSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var textView: NSTextView!
    @IBOutlet weak var convertionRadio: NSMatrix!
    @IBOutlet weak var standardRadio: NSMatrix!
    @IBOutlet weak var phraseCheck: NSButton!
    @IBOutlet weak var textRadio: NSMatrix!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        self.convertChinese(self)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    @IBAction func convertChinese(_ sender: AnyObject) {
        
        let cov = currentConvertion
        let std = currentStandard
        let phr = phraseState
        
        var convertOpt: ChineseConverter.ConvertOption = []
        
        if cov == [] && std == [] {
            convertOpt = [.traditionalize]
        } else {
            convertOpt.insert(cov)
            convertOpt.insert(std)
            convertOpt.insert(phr)
        }
        
        if let converter = ChineseConverter(convertOpt) {
            textView.string = converter.convert(string: currentText)
        }
    }
    
    var currentConvertion: ChineseConverter.ConvertOption {
        let index = convertionRadio.selectedColumn
        switch index {
        case 0:
            return [.simplize]
        case 1:
            return [.traditionalize]
        default:
            return []
        }
    }
    
    var currentStandard: ChineseConverter.ConvertOption {
        let index = standardRadio.selectedColumn
        switch index {
        case 0:
            return []
        case 1:
            return [.hkStandard]
        case 2:
            return [.taiwanStandard]
        default:
            return []
        }
    }
    
    var currentText: String {
        
        let textName = textRadio.selectedColumn == 0 ? "demo" : "mouse"
        
        guard let textURL = Bundle.main.url(forResource: textName, withExtension: "txt"),
              let text = try? String(contentsOf: textURL, encoding: .utf8)
        else { return "" }
        
        return text
    }
    
    var phraseState: ChineseConverter.ConvertOption {
        if phraseCheck.state == .on {
            return [.withPhrase]
        } else {
            return []
        }
    }
}

