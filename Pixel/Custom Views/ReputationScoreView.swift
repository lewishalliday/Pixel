//
//  ReputationScoreView.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import UIKit

class ReputationScoreView: UIView {
    enum ReputationLevel {
        case gold
        case silver
        case bronze

        var color: UIColor {
            switch self {
            case .gold:
                return UIColor(red: 255.0 / 255.0, green: 204.0 / 255.0, blue: 1.0 / 255.0, alpha: 1.0)
            case .silver:
                return UIColor(red: 180.0 / 255.0, green: 184.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
            case .bronze:
                return UIColor(red: 208.0 / 255.0, green: 166.0 / 255.0, blue: 132.0 / 255.0, alpha: 1.0)
            }
        }
    }

    private lazy var reputationScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var reputationScoreDotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        let stackView = UIStackView(arrangedSubviews: [reputationScoreDotView, reputationScoreLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            reputationScoreDotView.widthAnchor.constraint(equalToConstant: 12),
            reputationScoreDotView.heightAnchor.constraint(equalToConstant: 12),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func configure(with reputationLevel: ReputationLevel, badgeCount: Int) {
        reputationScoreDotView.backgroundColor = reputationLevel.color
        reputationScoreLabel.text = formatNumber(badgeCount)
    }
}
