//
//  SwiftUICell+UICollectionView.swift
//
//  Created by 1amageek on 2020/03/09.
//  Copyright © 2020 1amageek. All rights reserved.
//

import SwiftUI

#if os(iOS) || os(tvOS)

    import UIKit

    @available(iOS 13.0, *)
    public extension UICollectionView {
        func register<C: Cell>(content: C.Type) {
            register(SwiftUICell<C>.self, forCellWithReuseIdentifier: C.reusableIdentifier)
        }
    }

    @available(iOS 13.0, *)
    open class SwiftUICell<Content: Cell>: UICollectionViewCell {

        typealias ActionHandler = () -> Void

        class func dequeue(collectionView: UICollectionView, indexPath: IndexPath, contentView: Content, parent: UIViewController) -> Self {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Content.reusableIdentifier, for: indexPath) as! Self
            cell.parentViewController = parent
            cell.addContentView(contentView)
            return cell
        }


        class Proxy: ObservableObject {
            var handlers: [Content.HandleType: ActionHandler] = [:]
        }

        weak var parentViewController: UIViewController?

        let proxy: Proxy = Proxy()

        var hostingViewController: UIViewController? {
            didSet(oldValue) {
                guard let parentViewController = self.parentViewController else { return }
                guard let hostingViewController: UIViewController = oldValue else { return }
                hostingViewController.willMove(toParent: parentViewController)
                hostingViewController.view.removeFromSuperview()
                hostingViewController.removeFromParent()
            }
        }

        func addContentView(_ contentView: Content) {
            guard let parentViewController = self.parentViewController else { return }
            let hostingViewController: UIViewController = UIHostingController(rootView: contentView.environmentObject(self.proxy))
            parentViewController.addChild(hostingViewController)
            self.contentView.addSubview(hostingViewController.view)
            if let hostinView = hostingViewController.view {
                hostinView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate(
                    [
                        hostinView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                        hostinView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                        hostinView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                        hostinView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
                    ]
                )
            }
            hostingViewController.didMove(toParent: parentViewController)
            self.hostingViewController = hostingViewController
        }
    }

#endif

