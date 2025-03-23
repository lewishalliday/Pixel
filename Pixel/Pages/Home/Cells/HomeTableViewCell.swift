//
//  HomeTableViewCell.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell"
    var followTapped: (() -> Void)?

    // MARK: - UI Components

    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        return lbl
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black.withAlphaComponent(0.05)
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var followButton = FollowButton()
    private lazy var reputationView = ReputationView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(nameLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(reputationView)
        contentView.addSubview(followButton)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        reputationView.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Image Constraints
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),

            // Name Constraints
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),

            // Reputation Constraints
            reputationView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            reputationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            reputationView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            reputationView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            // Follow Button Constraints
            followButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            followButton.widthAnchor.constraint(equalToConstant: 70),
            followButton.heightAnchor.constraint(equalToConstant: 28),
        ])

        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
    }

    // MARK: - Configuration

    func configure(user: User, isFollowing: Bool) {
        nameLabel.text = user.displayName
        reputationView.configure(reputation: user.reputation, badges: user.badgeCounts)
        if let urlString = user.profileImage, let url = URL(string: urlString) {
            avatarImageView.imageFrom(url: url)
        }

        followButton.configure(state: isFollowing ? .following : .notFollowing)
    }

    @objc private func followButtonTapped() {
        followTapped?()
    }
}
