//
//  DefaultRouter.swift
//  RoutingExample
//
//  Created by Cassius Pacheco on 8/3/20.
//  Copyright © 2020 Cassius Pacheco. All rights reserved.
//

import UIKit

public class DefaultRouter: NSObject, Router, Closable, Dismissable {
    private let rootTransition: Transition
    public weak var root: UIViewController?

    public init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }

    deinit {
        print("🗑 Deallocating \(self) with \(String(describing: rootTransition))")
    }

    // MARK: - Routable

    public func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?) {
        guard let root = root else { return }
        transition.open(viewController, from: root, completion: completion)
    }

    public func route(to viewController: UIViewController, as transition: Transition) {
        route(to: viewController, as: transition, completion: nil)
    }

    // MARK: - Closable

    public func close(completion: (() -> Void)?) {
        guard let root = root else { return }
        // Removes the `root` with the same transition that it was opened.
        rootTransition.close(root, completion: completion)
    }

    public func close() {
        close(completion: nil)
    }

    // MARK: - Dismissable

    public func dismiss(completion: (() -> Void)?) {
        // Dismiss the root with iOS' default dismiss animation.
        // It will only work if the root or its ancestor were presented
        // using iOS' native present view controller method.
        root?.dismiss(animated: rootTransition.isAnimated, completion: completion)
    }

    public func dismiss() {
        dismiss(completion: nil)
    }
}
