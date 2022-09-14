//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import SwiftUI

@objc open class MSFShimmerLinesView: ControlHostingView {

    /// Creates a new MSFShimmerLinesView instance.
    /// - Parameters:
    ///   - style: The MSFShimmerStyle value used by the ShimmerView.
    ///   - lineCount: Number of lines that will shimmer in this view. Use 0 if the number of lines should fill the available space.
    ///   - firstLineFillPercent: The percent the first line (if 2+ lines) should fill the available horizontal space.
    ///   - lastLineFillPercent: The percent the last line should fill the available horizontal space.
    @objc public init(style: MSFShimmerStyle,
                      lineCount: Int,
                      firstLineFillPercent: CGFloat,
                      lastLineFillPercent: CGFloat) {
        shimmerLines = ShimmerLinesView(style: style,
                                        lineCount: lineCount,
                                        firstLineFillPercent: firstLineFillPercent,
                                        lastLineFillPercent: lastLineFillPercent)
        super.init(AnyView(shimmerLines))
    }

    required public init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    public var state: MSFShimmerLinesState {
        return shimmerLines.state
    }

    public var tokenSet: ShimmerTokenSet {
        return shimmerLines.tokenSet
    }

    private var shimmerLines: ShimmerLinesView!
}
