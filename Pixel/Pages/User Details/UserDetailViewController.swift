//
//  UserDetailViewController.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-04-02.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    let viewModel: UserDetailViewModel
    
    //MARK: - UI Elements
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        return button
    }()
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configure()
    }
    
    private func configure() {
        if let urlString = viewModel.user.profileImage, let url = URL(string: urlString) {
            profileImage.imageFrom(url: url)
        }
        
        if let name = viewModel.user.displayName {
            stackView.addArrangedSubview(createLabel(text: "Name: \(name)"))
        }
        
        stackView.addArrangedSubview(createLabel(text: "Reputation: \(viewModel.user.reputation)"))
        
        if let location = viewModel.user.location {
            stackView.addArrangedSubview(createLabel(text: "Location: \(location)"))
        }
        
        if let websiteUrl = viewModel.user.link {
            stackView.addArrangedSubview(createLabel(text: "Website URL: \(websiteUrl)"))
        }
        
        followingButton.setTitle(viewModel.isFollowingUser() ? "Unfollow" : "Follow", for: .normal)
        followingButton.addTarget(self, action: #selector(changeFollowingState), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(profileImage)
        view.addSubview(stackView)
        view.addSubview(followingButton)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        followingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            followingButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            followingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            followingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            followingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func changeFollowingState() {
        viewModel.toggleFollowingState() { following in
            if following {
                self.followingButton.setTitle("Unfollow", for: .normal)
            } else {
                self.followingButton.setTitle("Follow", for: .normal)
            }
        }
    }
}

extension UserDetailViewController {
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }
}
