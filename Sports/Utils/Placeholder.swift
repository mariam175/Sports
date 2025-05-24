//
//  Placeholder.swift
//  Sports
//
//  Created by Macos on 24/05/2025.
//

import Foundation

class Placeholder{
    static func placeholderImage(sport : String)->String{
        
        var placeholder = "placeholder"
        switch sport{
        case "football":
            placeholder = "footballPlaceholder"
        case "basketball":
            placeholder = "basketballPlaceholder"
        case "tennis":
            placeholder = "tennisPlaceholder"
        default:
            placeholder = "cricketPlaceholder"
        }
        return placeholder
    }
}
