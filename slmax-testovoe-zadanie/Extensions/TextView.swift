//
//  TextView.swift
//  slmax-testovoe-zadanie
//
//  Created by Александр on 07.12.2022.
//

import Foundation
import UIKit

extension UITextView {
    @IBInspectable var padding: CGFloat {
        get {
            return textContainer.lineFragmentPadding
        }
        set {
            textContainerInset = UIEdgeInsets.zero
            textContainer.lineFragmentPadding = newValue
        }
    }
}
