//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI
import UIKit

class NavigationControllerDemoController: DemoController {
    override func viewDidLoad() {
        super.viewDidLoad()

        readmeString = "The navigation bar provides information and actions relating to the current screen. It often shows the app or page title and allows for navigation relative to the current page, letting someone step forward and back through a flow. The left side of the navigation bar can contain actions that directly relate to that page’s content, like edit or done buttons.\n\nIf you need to show wayfinding for main sections of your app that don’t change as people move through it, try the tab bar."

        addTitle(text: "Large Title with Primary style")
        container.addArrangedSubview(createButton(title: "Show without accessory", action: #selector(showLargeTitle)))
        container.addArrangedSubview(createButton(title: "Show with collapsible search bar", action: #selector(showLargeTitleWithShyAccessory)))
        container.addArrangedSubview(createButton(title: "Show with fixed search bar", action: #selector(showLargeTitleWithFixedAccessory)))
        container.addArrangedSubview(createButton(title: "Show without an avatar", action: #selector(showLargeTitleWithoutAvatar)))
        container.addArrangedSubview(createButton(title: "Show with pill segmented control", action: #selector(showLargeTitleWithPillSegment)))

        addTitle(text: "Large Title with System style")
        container.addArrangedSubview(createButton(title: "Show without accessory", action: #selector(showLargeTitleWithSystemStyle)))
        container.addArrangedSubview(createButton(title: "Show without accessory and shadow", action: #selector(showLargeTitleWithSystemStyleAndNoShadow)))
        container.addArrangedSubview(createButton(title: "Show with collapsible search bar", action: #selector(showLargeTitleWithSystemStyleAndShyAccessory)))
        container.addArrangedSubview(createButton(title: "Show with fixed search bar", action: #selector(showLargeTitleWithSystemStyleAndFixedAccessory)))
        container.addArrangedSubview(createButton(title: "Show with pill segmented control", action: #selector(showLargeTitleWithSystemStyleAndPillSegment)))

        addTitle(text: "Regular Title")
        container.addArrangedSubview(createButton(title: "Show \"system\" with collapsible search bar", action: #selector(showRegularTitleWithShyAccessory)))
        container.addArrangedSubview(createButton(title: "Show \"primary\" with fixed search bar", action: #selector(showRegularTitleWithFixedAccessory)))

        addTitle(text: "Size Customization")
        container.addArrangedSubview(createButton(title: "Show with expanded avatar, contracted title", action: #selector(showLargeTitleWithCustomizedElementSizes)))

        addTitle(text: "Custom Navigation Bar Color")
        container.addArrangedSubview(createButton(title: "Show with gradient navigation bar color", action: #selector(showLargeTitleWithCustomizedColor)))

        addTitle(text: "Top Accessory View")
        container.addArrangedSubview(createButton(title: "Show with top search bar for large screen width", action: #selector(showWithTopSearchBar)))

        addTitle(text: "Change Style Periodically")
        container.addArrangedSubview(createButton(title: "Change the style every second", action: #selector(showSearchChangingStyleEverySecond)))
    }

    @objc func showLargeTitle() {
        presentController(withLargeTitle: true)
    }

    @objc func showLargeTitleWithShyAccessory() {
        presentController(withLargeTitle: true, accessoryView: createAccessoryView(), contractNavigationBarOnScroll: true)
    }

    @objc func showLargeTitleWithFixedAccessory() {
        presentController(withLargeTitle: true, accessoryView: createAccessoryView(), contractNavigationBarOnScroll: false)
    }

    @objc func showLargeTitleWithSystemStyle() {
        presentController(withLargeTitle: true, style: .system)
    }

    @objc func showLargeTitleWithSystemStyleAndNoShadow() {
        presentController(withLargeTitle: true, style: .system, contractNavigationBarOnScroll: false, showShadow: false)
    }

    @objc func showLargeTitleWithSystemStyleAndShyAccessory() {
        presentController(withLargeTitle: true, style: .system, accessoryView: createAccessoryView(with: .darkContent), contractNavigationBarOnScroll: true)
    }

    @objc func showLargeTitleWithSystemStyleAndFixedAccessory() {
        presentController(withLargeTitle: true, style: .system, accessoryView: createAccessoryView(with: .darkContent), contractNavigationBarOnScroll: false)
    }

    @objc func showLargeTitleWithSystemStyleAndPillSegment() {
        presentController(withLargeTitle: true, style: .system, accessoryView: createSegmentedControl(), contractNavigationBarOnScroll: false)
    }

    @objc func showRegularTitleWithShyAccessory() {
        presentController(withLargeTitle: false, style: .system, accessoryView: createAccessoryView(with: .darkContent), contractNavigationBarOnScroll: true)
    }

    @objc func showRegularTitleWithFixedAccessory() {
        presentController(withLargeTitle: false, accessoryView: createAccessoryView(), contractNavigationBarOnScroll: false)
    }

    @objc func showLargeTitleWithCustomizedElementSizes() {
        let controller = presentController(withLargeTitle: true, accessoryView: createAccessoryView())
        controller.msfNavigationBar.avatarSize = .expanded
        controller.msfNavigationBar.titleSize = .contracted
    }

    @objc func showLargeTitleWithCustomizedColor() {
        presentController(withLargeTitle: true, style: .custom, accessoryView: createAccessoryView())
    }

    @objc func showLargeTitleWithoutAvatar() {
        presentController(withLargeTitle: true, style: .primary, accessoryView: createAccessoryView(), showAvatar: false)
    }

    @objc func showWithTopSearchBar() {
        presentController(withLargeTitle: true, style: .system, accessoryView: createAccessoryView(with: .darkContent), showsTopAccessory: true, contractNavigationBarOnScroll: false)
    }

    @objc func showSearchChangingStyleEverySecond() {
        presentController(withLargeTitle: true, style: .system, accessoryView: createAccessoryView(with: .darkContent), showsTopAccessory: true, contractNavigationBarOnScroll: false, updateStylePeriodically: true)
    }

    @objc func showLargeTitleWithPillSegment() {
        presentController(withLargeTitle: true, accessoryView: createSegmentedControl(), contractNavigationBarOnScroll: false)
    }

    @discardableResult
    private func presentController(withLargeTitle useLargeTitle: Bool,
                                   style: NavigationBar.Style = .primary,
                                   accessoryView: UIView? = nil,
                                   showsTopAccessory: Bool = false,
                                   contractNavigationBarOnScroll: Bool = true,
                                   showShadow: Bool = true,
                                   showAvatar: Bool = true,
                                   updateStylePeriodically: Bool = false) -> NavigationController {
        let content = RootViewController()
        content.navigationItem.usesLargeTitle = useLargeTitle
        content.navigationItem.navigationBarStyle = style
        content.navigationItem.navigationBarShadow = showShadow ? .automatic : .alwaysHidden
        content.navigationItem.accessoryView = accessoryView
        content.navigationItem.topAccessoryViewAttributes = NavigationBarTopSearchBarAttributes()
        content.navigationItem.contentScrollView = contractNavigationBarOnScroll ? content.tableView : nil
        content.showsTopAccessoryView = showsTopAccessory

        content.navigationItem.customNavigationBarColor = CustomGradient.getCustomBackgroundColor(width: view.frame.width)

        if updateStylePeriodically {
            changeStyleContinuously(in: content.navigationItem)
        }

        let controller = NavigationController(rootViewController: content)
        if showAvatar {
            controller.msfNavigationBar.personaData = content.personaData
            controller.msfNavigationBar.onAvatarTapped = handleAvatarTapped
        } else {
            content.allowsCellSelection = true
        }

        if let searchBarView = accessoryView as? SearchBar {
            searchBarView.delegate = content
        }

        controller.modalPresentationStyle = .fullScreen
        if useLargeTitle {
            let leadingEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePan))
            leadingEdgeGesture.edges = view.effectiveUserInterfaceLayoutDirection == .leftToRight ? .left : .right
            leadingEdgeGesture.delegate = self
            controller.view.addGestureRecognizer(leadingEdgeGesture)
        }

        present(controller, animated: false)

        return controller
    }

    private func changeStyleContinuously(in navigationItem: UINavigationItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let newStyle: NavigationBar.Style
            switch navigationItem.navigationBarStyle {
            case .custom:
                newStyle = .default
            case .default:
                newStyle = .primary
            case .primary:
                newStyle = .system
            case .system:
                newStyle = .custom
            }

            navigationItem.navigationBarStyle = newStyle
            self.setNeedsStatusBarAppearanceUpdate()
            self.changeStyleContinuously(in: navigationItem)
        }
    }

    private func createAccessoryView(with style: SearchBar.Style = .lightContent) -> SearchBar {
        let searchBar = SearchBar()
        searchBar.style = style
        searchBar.placeholderText = "Search"
        return searchBar
    }

    private func createSegmentedControl() -> UIView {
        let segmentItems: [SegmentItem] = [
            SegmentItem(title: "First"),
            SegmentItem(title: "Second")]
        let pillControl = SegmentedControl(items: segmentItems, style: .onBrandPill)
        pillControl.shouldSetEqualWidthForSegments = false
        pillControl.isFixedWidth = false
        pillControl.contentInset = .zero
        let stackView = UIStackView()
        stackView.addArrangedSubview(pillControl)
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_fluent_filter_28"), for: .normal)
        button.tintColor = UIColor(dynamicColor: view.fluentTheme.aliasTokens.colors[.foregroundLightStatic])
        stackView.addArrangedSubview(button)
        return stackView
    }

    private func presentSideDrawer(presentingGesture: UIPanGestureRecognizer? = nil) {
        let meControl = Label(style: .title2, colorStyle: .regular)
        meControl.text = "Me Control goes here"
        meControl.textAlignment = .center

        let controller = DrawerController(sourceView: view, sourceRect: .zero, presentationDirection: .fromLeading)
        controller.contentView = meControl
        controller.preferredContentSize.width = 360
        controller.presentingGesture = presentingGesture
        controller.resizingBehavior = .dismiss
        presentedViewController?.present(controller, animated: true)
    }

    private func handleAvatarTapped() {
        presentSideDrawer()
    }

    @objc private func handleScreenEdgePan(gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .began {
            presentSideDrawer(presentingGesture: gesture)
        }
    }
}

// MARK: - NavigationControllerDemoController: UIGestureRecognizerDelegate

extension NavigationControllerDemoController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Only show side drawer for the root view controller
        if let controller = presentedViewController as? UINavigationController,
           gestureRecognizer is UIScreenEdgePanGestureRecognizer && gestureRecognizer.view == controller.view && controller.topViewController != controller.viewControllers.first {
            return false
        }
        return true
    }
}

// MARK: - RootViewController

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    enum BarButtonItemTag: Int {
        case dismiss
        case select
        case threeDay

        var title: String {
            switch self {
            case .dismiss:
                return "Dismiss"
            case .select:
                return "Select"
            case .threeDay:
                return "ThreeDay"
            }
        }
    }

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(BooleanCell.self, forCellReuseIdentifier: BooleanCell.identifier)
        tableView.register(ActionsCell.self, forCellReuseIdentifier: ActionsCell.identifier)
        return tableView
    }()

    var showSearchProgressSpinner: Bool = true
    var showRainbowRingForAvatar: Bool = false
    var showBadgeOnBarButtonItem: Bool = false

    var allowsCellSelection: Bool = false {
        didSet {
            updateRightBarButtonItems()
        }
    }

    var showsTopAccessoryView: Bool = false

    var personaData: PersonaData = {
        let personaData = PersonaData(name: "Kat Larsson", image: UIImage(named: "avatar_kat_larsson"))
        personaData.hasRingInnerGap = false
        return personaData
    }()

    private var isInSelectionMode: Bool = false {
        didSet {
            tableView.allowsMultipleSelection = isInSelectionMode

            for indexPath in tableView.indexPathsForVisibleRows ?? [] {
                if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
                    cell.setIsInSelectionMode(isInSelectionMode, animated: true)
                }
            }

            updateNavigationTitle()
            updateLeftBarButtonItems()
            updateRightBarButtonItems()
        }
    }

    private var navigationBarFrameObservation: NSKeyValueObservation?

    private let tabBarView: TabBarView = {
        let tabBarView = TabBarView()
        tabBarView.items = [
            TabBarItem(title: "Home", image: UIImage(named: "Home_28")!, selectedImage: UIImage(named: "Home_Selected_28")!, landscapeImage: UIImage(named: "Home_24")!, landscapeSelectedImage: UIImage(named: "Home_Selected_24")!),
            TabBarItem(title: "New", image: UIImage(named: "New_28")!, selectedImage: UIImage(named: "New_Selected_28")!, landscapeImage: UIImage(named: "New_24")!, landscapeSelectedImage: UIImage(named: "New_Selected_24")!),
            TabBarItem(title: "Open", image: UIImage(named: "Open_28")!, selectedImage: UIImage(named: "Open_Selected_28")!, landscapeImage: UIImage(named: "Open_24")!, landscapeSelectedImage: UIImage(named: "Open_Selected_24")!)
        ]
        return tabBarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        updateNavigationTitle()
        updateLeftBarButtonItems()
        updateRightBarButtonItems()

        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)

        let tabBarViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(tabBarViewConstraints)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        let size = tabBarView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        tableView.contentInset.bottom = size.height

        navigationBarFrameObservation = navigationController?.navigationBar.observe(\.frame, options: [.old, .new]) { [unowned self] navigationBar, change in
            if change.newValue?.width != change.oldValue?.width && self.navigationItem.navigationBarStyle == .custom {
                self.navigationItem.customNavigationBarColor = CustomGradient.getCustomBackgroundColor(width: navigationBar.frame.width)
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if showsTopAccessoryView {
            let showTopAccessoryView = view.frame.size.width >= Constants.topAccessoryViewWidthThreshold

            if let accessoryView = navigationItem.accessoryView as? SearchBar, showTopAccessoryView {
                accessoryView.hidesNavigationBarDuringSearch = false
                navigationItem.accessoryView = nil
                navigationItem.topAccessoryView = accessoryView
            } else if let accessoryView = navigationItem.topAccessoryView as? SearchBar, !showTopAccessoryView {
                accessoryView.hidesNavigationBarDuringSearch = true

                navigationItem.topAccessoryView = nil
                navigationItem.accessoryView = accessoryView
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BooleanCell.identifier, for: indexPath) as? BooleanCell else {
                return UITableViewCell()
            }
            cell.setup(title: "Show spinner while using the search bar", isOn: showSearchProgressSpinner)
            cell.titleNumberOfLines = 0
            cell.onValueChanged = { [weak self, weak cell] in
                self?.shouldShowSearchSpinner(isOn: cell?.isOn ?? false)
            }
            return cell
        }

        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BooleanCell.identifier, for: indexPath) as? BooleanCell else {
                return UITableViewCell()
            }
            let isSwitchEnabled = navigationItem.usesLargeTitle && msfNavigationController?.msfNavigationBar.personaData != nil
            cell.setup(title: "Show rainbow ring on avatar",
                       isOn: showRainbowRingForAvatar,
                       isSwitchEnabled: isSwitchEnabled)
            cell.titleNumberOfLines = 0
            cell.onValueChanged = { [weak self, weak cell] in
                self?.shouldShowRainbowRing(isOn: cell?.isOn ?? false)
            }
            return cell
        }

        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BooleanCell.identifier, for: indexPath) as? BooleanCell else {
                return UITableViewCell()
            }
            cell.setup(title: "Show badge on right bar button items",
                       isOn: showBadgeOnBarButtonItem,
                       isSwitchEnabled: navigationItem.usesLargeTitle)
            cell.titleNumberOfLines = 0
            cell.onValueChanged = { [weak self, weak cell] in
                self?.shouldShowBadge(isOn: cell?.isOn ?? false)
            }
            return cell
        }

        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionsCell.identifier, for: indexPath) as? ActionsCell else {
                return UITableViewCell()
            }
            cell.setup(action1Title: "Show tooltip on 3 day view button in navbar")
            cell.action1Button.addTarget(self, action: #selector(showTooltipButtonPressed), for: .touchUpInside)
            cell.bottomSeparatorType = .full
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let imageView = UIImageView(image: UIImage(named: "excelIcon"))
        cell.setup(title: "Cell #\(indexPath.row)", customView: imageView, accessoryType: .disclosureIndicator)
        cell.isInSelectionMode = isInSelectionMode
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isInSelectionMode {
            updateNavigationTitle()
        } else {
            let controller = ChildViewController()
            if navigationItem.accessoryView == nil {
                controller.navigationItem.navigationBarStyle = .system
            }
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if isInSelectionMode {
            updateNavigationTitle()
        }
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    private func updateNavigationTitle() {
        if isInSelectionMode {
            let selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
            navigationItem.title = selectedCount == 1 ? "1 item selected" : "\(selectedCount) items selected"
        } else {
            navigationItem.title = navigationItem.usesLargeTitle ? "Large Title" : "Regular Title"
        }
    }

    private func updateLeftBarButtonItems() {
        if isInSelectionMode {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Dismiss_28"), landscapeImagePhone: UIImage(named: "Dismiss_24"), style: .plain, target: self, action: #selector(dismissSelectionMode))
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }

    private func updateRightBarButtonItems() {
        if isInSelectionMode {
            navigationItem.rightBarButtonItems = nil
        } else {
            let dismissItem = UIBarButtonItem(title: BarButtonItemTag.dismiss.title, style: .plain, target: self, action: #selector(dismissSelf))
            dismissItem.tag = BarButtonItemTag.dismiss.rawValue
            dismissItem.accessibilityLabel = "Dismiss"
            var items = [dismissItem]
            if allowsCellSelection {
                let selectItem = UIBarButtonItem(title: BarButtonItemTag.select.title, style: .plain, target: self, action: #selector(showSelectionMode))
                selectItem.tag = BarButtonItemTag.select.rawValue
                items.append(selectItem)
            } else {
                let threeDayItem = UIBarButtonItem(image: UIImage(named: "3-day-view-28x28"), landscapeImagePhone: UIImage(named: "3-day-view-24x24"), style: .plain, target: self, action: #selector(showModalView))
                threeDayItem.accessibilityLabel = "Modal View"
                threeDayItem.tag = BarButtonItemTag.threeDay.rawValue
                items.append(threeDayItem)
            }
            navigationItem.rightBarButtonItems = items
        }
    }

    @objc private func shouldShowSearchSpinner(isOn: Bool) {
        showSearchProgressSpinner = isOn
    }

    @objc private func shouldShowRainbowRing(isOn: Bool) {
        personaData.imageBasedRingColor = isOn ? RootViewController.colorfulImageForFrame() : nil
        personaData.isRingVisible = isOn
        personaData.hasRingInnerGap = false
        msfNavigationController?.msfNavigationBar.personaData = personaData
        showRainbowRingForAvatar = isOn
    }

    @objc private func shouldShowBadge(isOn: Bool) {
        guard let items = navigationItem.rightBarButtonItems, !items.isEmpty else {
            return
        }
        for item in items {
            var badgeValue: String?
            var badgeAccessibilityLabel: String?
            if isOn {
                if item.tag == BarButtonItemTag.dismiss.rawValue {
                    badgeValue = "12345"
                    badgeAccessibilityLabel = "12345 items"
                } else if item.tag == BarButtonItemTag.threeDay.rawValue {
                    badgeValue = "12"
                    badgeAccessibilityLabel = "12 new items"
                } else {
                    badgeValue = "New"
                    badgeAccessibilityLabel = "New feature"
                }
            }
            item.setBadgeValue(badgeValue, badgeAccessibilityLabel: badgeAccessibilityLabel)
        }
        showBadgeOnBarButtonItem = isOn
    }

    @objc private func showTooltipButtonPressed() {
        let navigationBar = msfNavigationController?.msfNavigationBar
        guard let view = navigationBar?.barButtonItemView(with: BarButtonItemTag.threeDay.rawValue) else {
            return
        }
        Tooltip.shared.show(with: "Tap anywhere for this tooltip to dismiss.",
                            for: view,
                            preferredArrowDirection: .up,
                            dismissOn: .tapAnywhere)
    }

    @objc private func dismissSelf() {
        dismiss(animated: false)
    }

    @objc private func showModalView() {
        let modalNavigationController = UINavigationController(rootViewController: ModalViewController(style: .grouped))
        modalNavigationController.navigationBar.isTranslucent = true
        present(modalNavigationController, animated: true)
    }

    @objc private func showSelectionMode() {
        isInSelectionMode = true
        msfNavigationController?.contractNavigationBar(animated: true)
        msfNavigationController?.allowResizeOfNavigationBarOnScroll = false
    }

    @objc private func dismissSelectionMode() {
        isInSelectionMode = false
        msfNavigationController?.allowResizeOfNavigationBarOnScroll = true
        msfNavigationController?.expandNavigationBar(animated: true)
    }

    private static func colorfulImageForFrame() -> UIImage? {
        let gradientColors = [
            UIColor(red: 0.45, green: 0.29, blue: 0.79, alpha: 1).cgColor,
            UIColor(red: 0.18, green: 0.45, blue: 0.96, alpha: 1).cgColor,
            UIColor(red: 0.36, green: 0.80, blue: 0.98, alpha: 1).cgColor,
            UIColor(red: 0.45, green: 0.72, blue: 0.22, alpha: 1).cgColor,
            UIColor(red: 0.97, green: 0.78, blue: 0.27, alpha: 1).cgColor,
            UIColor(red: 0.94, green: 0.52, blue: 0.20, alpha: 1).cgColor,
            UIColor(red: 0.92, green: 0.26, blue: 0.16, alpha: 1).cgColor,
            UIColor(red: 0.45, green: 0.29, blue: 0.79, alpha: 1).cgColor]

        let colorfulGradient = CAGradientLayer()
        let size = CGSize(width: 76, height: 76)
        colorfulGradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        colorfulGradient.colors = gradientColors
        colorfulGradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        colorfulGradient.endPoint = CGPoint(x: 0.5, y: 0)
        colorfulGradient.type = .conic

        var customBorderImage: UIImage?
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            colorfulGradient.render(in: context)
            customBorderImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()

        return customBorderImage
    }
}

// MARK: - RootViewController: SearchBarDelegate

extension RootViewController: SearchBarDelegate {
    func searchBarDidBeginEditing(_ searchBar: SearchBar) {
        searchBar.progressSpinner.state.isAnimating = false
    }

    func searchBar(_ searchBar: SearchBar, didUpdateSearchText newSearchText: String?) {
    }

    func searchBarDidCancel(_ searchBar: SearchBar) {
        searchBar.progressSpinner.state.isAnimating = false
    }

    func searchBarDidRequestSearch(_ searchBar: SearchBar) {
        if showSearchProgressSpinner {
            searchBar.progressSpinner.state.isAnimating = true
        }
    }

    private struct Constants {
        static let topAccessoryViewWidthThreshold: CGFloat = 768
    }
}

// MARK: - ChildViewController

class ChildViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        navigationItem.title = "Regular Title"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.setup(title: "Child Cell #\(1 + indexPath.row)")
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - ModalViewController

class ModalViewController: UITableViewController {
    private var isGrouped: Bool = false {
        didSet {
            updateTableView()
        }
    }

    private var styleButtonTitle: String {
        return isGrouped ? "Switch to Plain style" : "Switch to Grouped style"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tintColor = DynamicColor(light: GlobalTokens.brandColors(.comm80),
                                     dark: GlobalTokens.neutralColors(.white))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(dynamicColor: tintColor)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(TableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TableViewHeaderFooterView.identifier)
        updateTableView()

        navigationItem.title = "Modal View"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissSelf))

        navigationController?.isToolbarHidden = false
        toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: styleButtonTitle, style: .plain, target: self, action: #selector(styleBarButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        ]
    }

    @objc private func dismissSelf() {
        dismiss(animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.setup(title: "Child Cell #\(1 + indexPath.row)")
        cell.backgroundStyleType = isGrouped ? .grouped : .plain
        cell.topSeparatorType = isGrouped && indexPath.row == 0 ? .full : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderFooterView.identifier) as? TableViewHeaderFooterView
        header?.setup(style: .header, title: "Section Header")
        return header
    }

    @objc private func styleBarButtonTapped(sender: UIBarButtonItem) {
        isGrouped = !isGrouped
        sender.title = styleButtonTitle
    }

    private func updateTableView() {
        tableView.backgroundColor = isGrouped ? TableViewCell.tableBackgroundGroupedColor : TableViewCell.tableBackgroundColor
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - Gradient Color

class CustomGradient {
    class func getCustomBackgroundColor(width: CGFloat) -> UIColor {
        let startColor: UIColor = #colorLiteral(red: 0.8156862745, green: 0.2156862745, blue: 0.3529411765, alpha: 1)
        let midColor: UIColor = #colorLiteral(red: 0.8470588235, green: 0.231372549, blue: 0.003921568627, alpha: 1)
        let endColor: UIColor = #colorLiteral(red: 0.8470588235, green: 0.231372549, blue: 0.003921568627, alpha: 1)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 1.0)
        gradientLayer.colors = [startColor.cgColor, midColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(light: image != nil ? UIColor(patternImage: image!) : endColor, dark: UIColor(colorValue: GlobalTokens.neutralColors(.grey16)))
    }
}
