//
//  FollowButton.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import UIKit

class FollowButton: UIButton {
    enum FollowState {
        case notFollowing
        case following

        var title: String {
            switch self {
            case .notFollowing:
                return "Follow"
            case .following:
                return "Unfollow"
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .notFollowing:
                return .systemBlue
            case .following:
                return .white
            }
        }

        var titleColor: UIColor {
            switch self {
            case .notFollowing:
                return .white
            case .following:
                return .systemBlue
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        layer.cornerRadius = 8
        titleLabel?.font = .systemFont(ofSize: 12)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
    }

    func configure(state: FollowState) {
        backgroundColor = state.backgroundColor
        setTitle(state.title, for: .normal)
        setTitleColor(state.titleColor, for: .normal)
    }
}
