//
// ChatLayout
// Cell.swift
// https://github.com/ekazaev/ChatLayout
//
// Created by Eugene Kazaev in 2020-2024.
// Distributed under the MIT license.
//
// Become a sponsor:
// https://github.com/sponsors/ekazaev
//

import ChatLayout
import DifferenceKit
import Foundation
import UIKit

enum Cell: Hashable {

    enum BubbleType {
        case normal
        case tailed
    }

    case message(Message, bubbleType: BubbleType)

    case typingIndicator

    case messageGroup(MessageGroup)

    case date(DateGroup)

    var alignment: ChatItemAlignment {
        switch self {
        case let .message(message, _):
            return message.type == .incoming ? .leading : .trailing
        case .typingIndicator:
            return .leading
        case let .messageGroup(group):
            return group.type == .incoming ? .leading : .trailing
        case .date:
            return .center
        }
    }

}

extension Cell: Differentiable {

    public var differenceIdentifier: Int {
        switch self {
        case let .message(message, _):
            return message.differenceIdentifier
        case .typingIndicator:
            return hashValue
        case let .messageGroup(group):
            return group.differenceIdentifier
        case let .date(group):
            return group.differenceIdentifier
        }
    }

    public func isContentEqual(to source: Cell) -> Bool {
        self == source
    }

}
