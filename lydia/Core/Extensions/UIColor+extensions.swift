//
//  UIColor+extensions.swift
//  lydia
//
//  Created by Noeline PAGESY on 09/08/2022.
//

import Foundation
import UIKit

extension UIColor {
    static func load(named: String) -> UIColor { UIColor(named: named) ?? .black }
    
    static var backgroundColor: UIColor { .load(named: "backgroundColor") }
    static var primaryColor: UIColor { .load(named: "primaryColor") }
    static var secondaryColor: UIColor { .load(named: "secondaryColor") }
}
