//
//  File.swift
//  
//
//  Created by nori on 2020/03/11.
//

import SwiftUI

#if os(iOS) || os(tvOS)
    import UIKit
    public typealias UserInterfaceItemIdentifier = String
#endif

#if os(macOS)
    import AppKit
    public typealias UserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier
#endif

public protocol Cell: View {
    associatedtype HandleType: Hashable = String
    static var reusableIdentifier: UserInterfaceItemIdentifier { get }
}

public extension Cell {
    #if os(iOS) || os(tvOS)
        static var reusableIdentifier: UserInterfaceItemIdentifier { "\(Self.self)" }
    #endif

    #if os(macOS)
        static var reusableIdentifier: UserInterfaceItemIdentifier { NSUserInterfaceItemIdentifier(rawValue: "\(Self.self)") }
    #endif
}
