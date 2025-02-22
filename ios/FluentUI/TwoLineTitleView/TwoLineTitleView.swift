//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

// MARK: TwoLineTitleViewDelegate

@objc(MSFTwoLineTitleViewDelegate)
public protocol TwoLineTitleViewDelegate: AnyObject {
    func twoLineTitleViewDidTapOnTitle(_ twoLineTitleView: TwoLineTitleView)
}

// MARK: - TwoLineTitleView

@objc(MSFTwoLineTitleView)
open class TwoLineTitleView: UIView {
    private struct Constants {
        static let titleButtonLabelMarginBottomRegular: CGFloat = 0
        static let titleButtonLabelMarginBottomCompact: CGFloat = -2
        static let colorAnimationDuration: TimeInterval = 0.2
        static let colorAlpha: CGFloat = 1.0
        static let colorHighlightedAlpha: CGFloat = 0.4
    }

    @objc(MSFTwoLineTitleViewStyle)
    public enum Style: Int {
        case primary
        case system
    }

    @objc(MSFTwoLineTitleViewInteractivePart)
    public enum InteractivePart: Int {
        case none
        case title
        case subtitle
    }

    @objc(MSFTwoLineTitleViewAccessoryType)
    public enum AccessoryType: Int {
        case none
        case disclosure
        case downArrow

        var image: UIImage? {
            let image: UIImage?
            switch self {
            case .disclosure:
                image = UIImage.staticImageNamed("chevron-right-20x20")
            case .downArrow:
                image = UIImage.staticImageNamed("chevron-down-20x20")
            case .none:
                image = nil
            }
            return image
        }

        var size: CGSize { return image?.size ?? .zero }

        var horizontalPadding: CGFloat {
            switch self {
            case .disclosure:
                return 0
            case .downArrow:
                return -1
            case .none:
                return 0
            }
        }

        var areaWidth: CGFloat {
            return (size.width + horizontalPadding) * 2
        }
    }

    @objc open var titleAccessibilityHint: String? {
        get { return titleButton.accessibilityHint }
        set { titleButton.accessibilityHint = newValue }
    }
    @objc open var titleAccessibilityTraits: UIAccessibilityTraits {
        get { return titleButton.accessibilityTraits }
        set { titleButton.accessibilityTraits = newValue }
    }

    @objc open var subtitleAccessibilityHint: String? {
        get { return subtitleButton.accessibilityHint }
        set { subtitleButton.accessibilityHint = newValue }
    }
    @objc open var subtitleAccessibilityTraits: UIAccessibilityTraits {
        get { return subtitleButton.accessibilityTraits }
        set { subtitleButton.accessibilityTraits = newValue }
    }

    @objc public weak var delegate: TwoLineTitleViewDelegate?

    private var interactivePart: InteractivePart = .none
    private var accessoryType: AccessoryType = .none

    private let titleButton = EasyTapButton()
    private var titleAccessoryType: AccessoryType {
        return interactivePart == .title ? accessoryType : .none
    }

    private var currentStyle: Style

    private lazy var titleButtonLabel: Label = {
        let label = Label()
        label.lineBreakMode = .byTruncatingTail
        label.style = .body1Strong
        label.maxFontSize = 17
        label.textAlignment = .center
        return label
    }()

    private var titleButtonImageView = UIImageView()

    private let subtitleButton = EasyTapButton()
    private var subtitleAccessoryType: AccessoryType {
        return interactivePart == .subtitle ? accessoryType : .none
    }

    private lazy var subtitleButtonLabel: Label = {
        let label = Label()
        label.lineBreakMode = .byTruncatingMiddle
        label.style = .caption1
        label.maxFontSize = 12
        return label
    }()

    private var subtitleButtonImageView = UIImageView()

    @objc public convenience init(style: Style = .primary) {
        self.init(frame: .zero)
        self.currentStyle = style

        applyStyle()
    }

    public override init(frame: CGRect) {
        self.currentStyle = .system

        super.init(frame: frame)

        applyStyle()

        titleButton.addTarget(self, action: #selector(onTitleButtonHighlighted), for: [.touchDown, .touchDragInside, .touchDragEnter])
        titleButton.addTarget(self, action: #selector(onTitleButtonUnhighlighted), for: [.touchUpInside, .touchDragOutside, .touchDragExit])
        titleButton.addTarget(self, action: #selector(onTitleButtonTapped), for: [.touchUpInside])
        addSubview(titleButton)

        titleButton.addSubview(titleButtonLabel)
        titleButton.addSubview(titleButtonImageView)

        subtitleButton.addTarget(self, action: #selector(onSubtitleButtonHighlighted), for: [.touchDown, .touchDragInside, .touchDragEnter])
        subtitleButton.addTarget(self, action: #selector(onSubtitleButtonUnhighlighted), for: [.touchUpInside, .touchDragOutside, .touchDragExit])
        subtitleButton.addTarget(self, action: #selector(onTitleButtonTapped), for: [.touchUpInside])
        addSubview(subtitleButton)

        subtitleButton.addSubview(subtitleButtonLabel)
        subtitleButton.addSubview(subtitleButtonImageView)

        setupTitleButtonColor(highlighted: false, animated: false)
        setupSubtitleButtonColor(highlighted: false, animated: false)

        titleButtonImageView.contentMode = .scaleAspectFit
        subtitleButtonImageView.contentMode = .scaleAspectFit

        titleButton.accessibilityTraits = [.staticText, .header]
        subtitleButton.accessibilityTraits = [.staticText, .header]

        addInteraction(UILargeContentViewerInteraction())
        titleButtonLabel.showsLargeContentViewer = true
        subtitleButtonLabel.showsLargeContentViewer = true

        updateFonts()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(themeDidChange),
                                               name: .didChangeTheme,
                                               object: nil)
    }

    @objc private func themeDidChange(_ notification: Notification) {
        guard let themeView = notification.object as? UIView, self.isDescendant(of: themeView) else {
            return
        }
        applyStyle()
    }

    public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    // MARK: Setup

    /// Sets the relevant strings and button styles for the title and subtitle.
    ///
    /// - Parameters:
    ///   - title: A title string.
    ///   - subtitle: An optional subtitle string. If nil, title will take up entire frame.
    ///   - interactivePart: Determines which line, if any, of the view will have interactive button behavior.
    ///   - accessoryType: Determines which accessory will be shown with the `interactivePart` of the view, if any. Ignored if `interactivePart` is `.none`.
    @objc open func setup(title: String, subtitle: String? = nil, interactivePart: InteractivePart = .none, accessoryType: AccessoryType = .none) {
        self.interactivePart = interactivePart
        self.accessoryType = accessoryType

        setupButton(titleButton, label: titleButtonLabel, imageView: titleButtonImageView, text: title, interactive: interactivePart == .title, accessoryType: accessoryType)
        setupButton(subtitleButton, label: subtitleButtonLabel, imageView: subtitleButtonImageView, text: subtitle, interactive: interactivePart == .subtitle, accessoryType: accessoryType)

        setNeedsLayout()
    }

    // MARK: Highlighting

    private func applyStyle() {
        switch currentStyle {
        case .system:
            titleButtonLabel.textColor = UIColor(dynamicColor: fluentTheme.aliasTokens.colors[.foreground1])
            subtitleButtonLabel.textColor = UIColor(dynamicColor: fluentTheme.aliasTokens.colors[.foreground2])
            titleButtonImageView.tintColor = UIColor(dynamicColor: fluentTheme.aliasTokens.colors[.foreground2])
        case .primary:
            titleButtonLabel.textColor = UIColor(dynamicColor: DynamicColor(light: fluentTheme.aliasTokens.colors[.foregroundOnColor].light,
                                                                            dark: fluentTheme.aliasTokens.colors[.foreground1].dark))
            subtitleButtonLabel.textColor = UIColor(dynamicColor: DynamicColor(light: fluentTheme.aliasTokens.colors[.foregroundOnColor].light,
                                                                               dark: fluentTheme.aliasTokens.colors[.foreground2].dark))
            titleButtonImageView.tintColor = UIColor(dynamicColor: DynamicColor(light: fluentTheme.aliasTokens.colors[.foregroundOnColor].light,
                                                                                dark: fluentTheme.aliasTokens.colors[.foreground2].dark))
        }

        // unlike title accessory image view, subtitle accessory image view should be the same color as subtitle label
        subtitleButtonImageView.tintColor = subtitleButtonLabel.textColor
    }

    private func setupTitleButtonColor(highlighted: Bool, animated: Bool) {
        setupColor(highlighted: highlighted, animated: animated, onLabel: titleButtonLabel, onImageView: titleButtonImageView)
    }

    private func setupSubtitleButtonColor(highlighted: Bool, animated: Bool) {
        setupColor(highlighted: highlighted, animated: animated, onLabel: subtitleButtonLabel, onImageView: subtitleButtonImageView)
    }

    private func setupColor(highlighted: Bool, animated: Bool, onLabel label: UILabel, onImageView imageView: UIImageView) {
        // Highlighting is never animated to match iOS
        let duration = !highlighted && animated ? Constants.colorAnimationDuration : 0

        UIView.animate(withDuration: duration) {
            // Button label
            label.alpha = (highlighted) ? Constants.colorHighlightedAlpha : Constants.colorAlpha

            // Button image view
            imageView.alpha = (highlighted) ? Constants.colorHighlightedAlpha : Constants.colorAlpha
        }
    }

    private func setupButton(_ button: UIButton, label: UILabel, imageView: UIImageView, text: String?, interactive: Bool, accessoryType: AccessoryType) {
        button.isUserInteractionEnabled = interactive
        button.accessibilityLabel = text
        if interactive {
            button.accessibilityTraits.insert(.button)
            button.accessibilityTraits.remove(.staticText)
        } else {
            button.accessibilityTraits.insert(.staticText)
            button.accessibilityTraits.remove(.button)
        }

        label.text = text
        imageView.image = accessoryType.image
        imageView.isHidden = imageView.image == nil
    }

    // MARK: Layout

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var titleSize = titleButtonLabel.sizeThatFits(size)
        titleSize.width += titleAccessoryType.areaWidth

        var subtitleSize = subtitleButtonLabel.sizeThatFits(size)
        subtitleSize.width += subtitleAccessoryType.areaWidth

        return CGSize(width: max(titleSize.width, subtitleSize.width), height: titleSize.height + subtitleSize.height)
    }

    private func updateFonts() {
        titleButtonLabel.font = UIFont.fluent(fluentTheme.aliasTokens.typography[.body1Strong])
        subtitleButtonLabel.font = UIFont.fluent(fluentTheme.aliasTokens.typography[.caption1])
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        let isCompact = traitCollection.verticalSizeClass == .compact

        let titleButtonHeight = titleButtonLabel.font.lineHeight
        let titleBottomMargin = isCompact ? Constants.titleButtonLabelMarginBottomCompact : Constants.titleButtonLabelMarginBottomRegular
        let subtitleButtonHeight = subtitleButtonLabel.font.lineHeight
        let totalContentHeight = titleButtonHeight + titleBottomMargin + subtitleButtonHeight
        var top = ceil((bounds.height - totalContentHeight) / 2.0)

        titleButton.frame = CGRect(x: 0, y: top, width: bounds.width, height: titleButtonHeight).integral
        top += titleButtonHeight + titleBottomMargin

        let titleButtonLabelMaxWidth = titleButton.bounds.width - titleAccessoryType.areaWidth
        titleButtonLabel.sizeToFit()
        let titleButtonLabelWidth = min(titleButtonLabelMaxWidth, titleButtonLabel.frame.width)
        titleButtonLabel.frame = CGRect(
            x: ceil((titleButton.frame.width - titleButtonLabelWidth) / 2.0),
            y: 0,
            width: titleButtonLabelWidth,
            height: titleButton.frame.height
        )

        titleButtonImageView.frame = CGRect(
            origin: CGPoint(x: titleButtonLabel.frame.maxX + titleAccessoryType.horizontalPadding, y: 0),
            size: titleAccessoryType.size
        )

        titleButtonImageView.centerInSuperview(horizontally: false, vertically: true)

        if subtitleButtonLabel.text != nil {
            subtitleButton.frame = CGRect(x: frame.origin.x, y: top, width: bounds.width, height: subtitleButtonHeight).integral

            let subtitleButtonLabelMaxWidth = interactivePart == .subtitle ? subtitleButton.bounds.width - subtitleAccessoryType.areaWidth : titleButton.bounds.width
            subtitleButtonLabel.sizeToFit()
            let subtitleButtonLabelWidth = min(subtitleButtonLabelMaxWidth, subtitleButtonLabel.frame.width)
            subtitleButtonLabel.frame = CGRect(
                x: ceil((subtitleButton.frame.width - subtitleButtonLabelWidth) / 2.0),
                y: 0,
                width: subtitleButtonLabelWidth,
                height: subtitleButton.frame.height
            )
            subtitleButtonImageView.frame = CGRect(
                x: subtitleButtonLabel.frame.maxX + subtitleAccessoryType.horizontalPadding,
                y: ceil((subtitleButton.frame.height - subtitleAccessoryType.size.height) / 2.0),
                width: subtitleAccessoryType.size.width,
                height: subtitleAccessoryType.size.height
            )
        } else {
            // The view is configured as a single line (title) view only.
            titleButton.centerInSuperview()
        }

        titleButton.flipSubviewsForRTL()
        subtitleButton.flipSubviewsForRTL()
    }

    // MARK: Actions

    @objc private func onTitleButtonHighlighted() {
        setupTitleButtonColor(highlighted: true, animated: true)
    }

    @objc private func onTitleButtonUnhighlighted() {
        setupTitleButtonColor(highlighted: false, animated: true)
    }

    @objc private func onTitleButtonTapped() {
        delegate?.twoLineTitleViewDidTapOnTitle(self)
    }

    @objc private func onSubtitleButtonHighlighted() {
        setupSubtitleButtonColor(highlighted: true, animated: true)
    }

    @objc private func onSubtitleButtonUnhighlighted() {
        setupSubtitleButtonColor(highlighted: false, animated: true)
    }

    // MARK: Accessibility

    open override var isAccessibilityElement: Bool { get { return false } set { } }

    open override func accessibilityElementCount() -> Int {
        return subtitleButtonLabel.text != nil ? 2 : 1
    }

    open override func accessibilityElement(at index: Int) -> Any? {
        if index == 0 {
            return titleButton
        } else if index == 1 {
            return subtitleButton
        }
        return nil
    }

    open override func index(ofAccessibilityElement element: Any) -> Int {
        if let view = element as? UIView {
            return view == titleButton ? 0 : 1
        }
        return -1
    }
}
