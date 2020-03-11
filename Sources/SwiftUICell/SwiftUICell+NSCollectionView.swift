//
//  SwiftUICell+NSCollectionView.swift
//  
//  Created by 1amageek on 2020/03/09.
//  Copyright © 2020 1amageek. All rights reserved.
//

import SwiftUI

#if os(macOS)

    import AppKit

    @available(OSX 10.15, *)
    extension NSCollectionView {
        func register<C: Cell>(content: C.Type) {
            register(SwiftUICell<C>.self, forItemWithIdentifier: C.reusableIdentifier)
        }
    }

    @available(OSX 10.15, *)
    class SwiftUICell<Content: Cell>: NSCollectionViewItem {

        typealias ActionHandler = () -> Void

        class func dequeue(collectionView: NSCollectionView, indexPath: IndexPath, contentView: Content, parent: NSViewController) -> Self {
            let cell = collectionView.makeItem(withIdentifier: Content.reusableIdentifier, for: indexPath) as! Self
            cell.parent = parent
            cell.addContentView(contentView)
            return cell
        }

        class Proxy: ObservableObject {
            var handlers: [Content.HandleType: ActionHandler] = [:]
        }

        weak var parent: NSViewController?

        let proxy: Proxy = Proxy()

        var hostingViewController: NSViewController? {
            didSet(oldValue) {
                guard let parentViewController = self.parent else { return }
                guard let hostingViewController: NSViewController = oldValue else { return }
                hostingViewController.willMove(toParent: parentViewController)
                hostingViewController.view.removeFromSuperview()
                hostingViewController.removeFromParent()
            }
        }

        func addContentView(_ contentView: Content) {
            guard let parentViewController = self.parent else { return }
            let hostingViewController: NSViewController = NSHostingController(rootView: contentView.environmentObject(self.proxy))
            parentViewController.addChild(hostingViewController)
            self.view.addSubview(hostingViewController.view)
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
