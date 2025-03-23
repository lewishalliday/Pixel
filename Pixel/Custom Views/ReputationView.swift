//
//  ReputationView.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import UIKit

class ReputationView: UIView {
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var reputationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .label
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func configure(reputation: Int, badges: BadgeCounts) {
        clearStackView()
        setReputationLabel(reputation)
        addBadges(badges)
    }

    private func clearStackView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    private func setReputationLabel(_ reputation: Int) {
        reputationLabel.text = formatNumber(reputation)
        stackView.addArrangedSubview(reputationLabel)
    }

    private func addBadges(_ badges: BadgeCounts) {
        if let gold = badges.gold {
            addBadge(badgeCount: gold, badgeType: .gold)
        }
        if let silver = badges.silver {
            addBadge(badgeCount: silver, badgeType: .silver)
        }
        if let bronze = badges.bronze {
            addBadge(badgeCount: bronze, badgeType: .bronze)
        }
    }

    private func addBadge(badgeCount: Int, badgeType: ReputationScoreView.ReputationLevel) {
        guard badgeCount > 0 else { return }
        let badgeView = ReputationScoreView()
        badgeView.configure(with: badgeType, badgeCount: badgeCount)
        stackView.addArrangedSubview(badgeView)
    }
}
