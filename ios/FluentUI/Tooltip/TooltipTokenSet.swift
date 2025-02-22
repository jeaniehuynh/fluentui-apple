//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

/// Design token set for the `Tooltip` control.
public class TooltipTokenSet: ControlTokenSet<TooltipTokenSet.Tokens> {
    public enum Tokens: TokenSetKey {
        /// The color of the body of the tooltip.
        case tooltipColor

        /// The color of the text within the tooltip.
        case textColor

        /// The information for the tooltip's shadow.
        case shadowInfo

        /// The radius for the corners of the tooltip.
        case backgroundCornerRadius

        /// The TextStyle of the message label.
        case messageLabelTextStyle

        /// The TextStyle of the title label.
        case titleLabelTextStyle

        /// The maximum width of the tooltip if the device's text size is not an accessibility size (in which case there is no maximum width).
        case maximumWidth

        /// The height of the arrow of the tooltip.
        case arrowHeight

        /// The width of the arrow of the tooltip.
        case arrowWidth
    }

    init() {
        super.init { token, theme in
            switch token {
            case .tooltipColor:
                return .dynamicColor { theme.aliasTokens.colors[.backgroundDarkStatic] }

            case .textColor:
                return .dynamicColor { theme.aliasTokens.colors[.foregroundLightStatic] }

            case .shadowInfo:
                return .shadowInfo { theme.aliasTokens.shadow[.shadow16] }

            case .backgroundCornerRadius:
                return .float { GlobalTokens.corner(.radius80) }

            case .messageLabelTextStyle:
                return .fontInfo { theme.aliasTokens.typography[.body2] }

            case .titleLabelTextStyle:
                return .fontInfo { theme.aliasTokens.typography[.body1Strong] }

            case .maximumWidth:
                return .float { 250.0 }

            case .arrowHeight:
                return .float { 7.0 }

            case .arrowWidth:
                return .float { 14.0 }
            }
        }
    }
}

// MARK: Constants
extension TooltipTokenSet {

    /// The horizontal padding between the text and edges of the tooltip.
    static let paddingHorizontal: CGFloat = GlobalTokens.spacing(.size120)

    /// The vertical padding between the text and edges of the tooltip with both a title and message.
    static let paddingVerticalWithTitle: CGFloat = GlobalTokens.spacing(.size120)

    /// The vertical padding between the text and edges of the tooltip with just a message.
    static let paddingVerticalWithoutTitle: CGFloat = GlobalTokens.spacing(.size80)

    /// The vertical spacing between the title and message.
    static let spacingVertical: CGFloat = GlobalTokens.spacing(.size80)

    /// The margins from the window's safe area insets used for laying out the tooltip.
    static let screenMargin: CGFloat = GlobalTokens.spacing(.size160)

}
