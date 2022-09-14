//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import SwiftUI
import UIKit
import Combine

@objc open class MSFShimmerView: ControlHostingView {

    /// Creates a new MSFShimmerView instance.
    /// - Parameters:
    ///   - style: The MSFShimmerStyle value used by the Shimmer.
    ///   - viewToShimmer: View to add the shimmering effect to.
    @objc public init(style: MSFShimmerStyle,
                      viewToShimmer: UIView) {
        adaptedViewToShimmer = AnyView(UIViewAdapter(viewToShimmer)
            .shimmering(style: style,
                        shouldAddShimmeringCover: true,
                        usesTextHeightForLabels: true,
                        isLabel: true,
                        isShimmering: true))
        super.init(adaptedViewToShimmer)
    }

    required public init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    @objc public var state: MSFShimmerState {
        return shimmer.state
    }

    public var tokenSet: ShimmerTokenSet {
        return shimmer.tokenSet
    }

    private var shimmer: ShimmerView!
    private var adaptedViewToShimmer: AnyView
}
