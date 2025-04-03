//
//  HomeViewModel.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import Combine
import Foundation

class HomeViewModel {
    private let followingManager = FollowingManager()
    
    let coordinator: Coordinator
    let networkManager: NetworkAbstraction

    @Published private(set) var isLoading: Bool = false
    @Published private(set) var users: [User] = []

    init(coordinator: Coordinator, networkManager: NetworkAbstraction) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        
        Task {
            do {
                try await loadUsersData()
            } catch { }
        }
    }

    // MARK: - Networking
    func loadUsersData() async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            let userResponse: UserData = try await networkManager.fetchData(endpoint: "users", queryItems: [
                "page": "1",
                "pagesize": "20",
                "order": "desc",
                "sort": "reputation",
                "site": "stackoverflow",
            ])
            self.users = userResponse.user
        } catch {
            print("Error: \(error)")
        }
    }

    func isFollowing(userId: Int) -> Bool {
        followingManager.isFollowing(userId: userId)
    }

    func toggleFollowingState(userId: Int) {
        if followingManager.isFollowing(userId: userId) {
            followingManager.unfollow(userId: userId)
        } else {
            followingManager.follow(userId: userId)
        }
    }
    
    func presentUserDetail(for indexPath: IndexPath) {
        let user = users[indexPath.row]
        coordinator.presetUserDetailModal(user: user)
    }
}
