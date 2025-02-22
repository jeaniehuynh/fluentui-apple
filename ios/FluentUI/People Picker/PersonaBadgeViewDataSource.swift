//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

// MARK: PersonaBadgeViewDataSource

@objc(MSFPersonaBadgeViewDataSource)
open class PersonaBadgeViewDataSource: BadgeViewDataSource {
    @objc open var persona: Persona

    @objc public init(persona: Persona, style: BadgeView.Style = .default, size: BadgeView.Size = .medium) {
        self.persona = persona
        super.init(text: persona.name, style: style, size: size)
    }

    @objc public convenience init(persona: Persona, style: BadgeView.Style = .default, size: BadgeView.Size = .medium, customView: UIView? = nil) {
        self.init(persona: persona, style: style, size: size)
        super.customView = customView
    }
}
