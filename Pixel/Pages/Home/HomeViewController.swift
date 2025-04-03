//
//  HomeViewController.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import Combine
import Foundation
import UIKit

class HomeViewController: UIViewController {
    /// ViewModel
    private let viewModel: HomeViewModel

    /// Cancellables
    private var cancellables: [AnyCancellable] = []

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.allowsSelection = true
        table.delegate = self
        table.dataSource = self
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return table
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "There has been an issue.\nPlease try again later."
        label.textColor = .label.withAlphaComponent(0.4)
        label.textAlignment = .center
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializers

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Subscribe to viewmodel
    private func subscribe() {
        viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.updateEmptyState()
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
                self.updateEmptyState()
            }
            .store(in: &cancellables)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        subscribe()
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(emptyStateLabel)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func updateEmptyState() {
        emptyStateLabel.isHidden = !(viewModel.users.isEmpty && !viewModel.isLoading)
        tableView.isHidden = viewModel.users.isEmpty && viewModel.isLoading
    }
}

// MARK: - TableView DataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let user = viewModel.users[indexPath.row]
        cell.configure(user: user, isFollowing: viewModel.isFollowing(userId: user.accountID))
        cell.followTapped = { [weak self] in
            self?.viewModel.toggleFollowingState(userId: user.accountID)
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
}

// MARK: - TableView Delegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt index: IndexPath) {
        tableView.deselectRow(at: index, animated: true)
        viewModel.presentUserDetail(for: index)
    }
}
