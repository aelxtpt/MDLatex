#if os(iOS) || os(tvOS)
import SwiftUI
import UIKit

extension Color {
    /// Converte `Color` (SwiftUI) para String em Hex, incluindo (opcionalmente) o canal alpha.
    func toHexString(includeAlpha: Bool = false) -> String {
        let uiColor = UIColor(self)

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return "#000000"
        }

        if a == 0 {
            return "transparent"
        }

        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X",
                          Int(r * 255),
                          Int(g * 255),
                          Int(b * 255),
                          Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X",
                          Int(r * 255),
                          Int(g * 255),
                          Int(b * 255))
        }
    }

    /// Converte `Color` (SwiftUI) para `UIColor` (iOS).
    func toUIColor() -> UIColor {
        UIColor(self)
    }
}

#elseif os(macOS)
import SwiftUI
import AppKit

extension Color {
    /// Converte `Color` (SwiftUI) para String em Hex, incluindo (opcionalmente) o canal alpha.
    func toHexString(includeAlpha: Bool = false) -> String {
        // Converte Color -> NSColor
        let nsColor = NSColor(self)

        // Precisamos converter para um espaço de cor RGB antes de extrair componentes
        guard let rgbColor = nsColor.usingColorSpace(.deviceRGB) else {
            return "#000000"
        }
        
        let r = rgbColor.redComponent
        let g = rgbColor.greenComponent
        let b = rgbColor.blueComponent
        let a = rgbColor.alphaComponent

        if a == 0 {
            return "transparent"
        }

        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X",
                          Int(r * 255),
                          Int(g * 255),
                          Int(b * 255),
                          Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X",
                          Int(r * 255),
                          Int(g * 255),
                          Int(b * 255))
        }
    }

    /// Converte `Color` (SwiftUI) para `NSColor` (macOS).
    func toNSColor() -> NSColor {
        NSColor(self)
    }
}
#endif