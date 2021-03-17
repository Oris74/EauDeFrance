//
//  String.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 09/03/2021.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            
            let test = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil  )
            
            return test
        } catch {
            return nil
        }
    }
    var htmlToString: NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        
        return  NSAttributedString(string: self, attributes: attributes)
    }
}
