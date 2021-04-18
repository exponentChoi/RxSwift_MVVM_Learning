//
//  String+Extension.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/18.
//

import UIKit

extension String {
    // html 태그 제거 + html entity들 디코딩.
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData,
                                                    options: options,
                                                    documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
    
    /// html 태그 NSAttributedString 변환
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    /// 기본 font 적용 후 html  태그 적용
    var htmlToAttributedString2: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        var attribStr = NSMutableAttributedString()
        
        do {//, allowLossyConversion: true
            let textRangeForFont : NSRange = NSMakeRange(0, attribStr.length)
            attribStr.addAttributes([NSAttributedString.Key.font : UIFont(name: "Arial", size:35)!,NSAttributedString.Key.foregroundColor: UIColor.black.cgColor], range: textRangeForFont)
            attribStr = try NSMutableAttributedString(data: data, options: [ .documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            
            
        } catch {
            print(error)
        }
        
        return attribStr
    }
}
