//
//  PixelTests.swift
//  PixelTests
//
//  Created by Lewis Halliday on 2025-04-02.
//

import XCTest
@testable import Pixel

final class PixelTests: XCTestCase {
    
    func testPresentUserDetail() async throws {
        let testCoordinator = TestCoordinator()
        let homeViewModel = HomeViewModel(coordinator: testCoordinator, networkManager: TestNetworkManager())
        
        try await homeViewModel.loadUsersData()
        homeViewModel.presentUserDetail(for: IndexPath(row: 8, section: 0))
        
        XCTAssertEqual(testCoordinator.user?.accountID, 123456789)
    }
}

class TestCoordinator: Coordinator {
    var user: User?
    
    func start() {
        
    }
    
    func presetUserDetailModal(user: Pixel.User) {
        self.user = user
    }
}


class TestNetworkManager: NetworkAbstraction {
    var baseUrl: String = ""
    
    func fetchData<T>(endpoint: String, queryItems: [String : String]) async throws -> T where T : Decodable {
        var users: [User] = []
        users.append(User(badgeCounts: BadgeCounts(bronze: 1234, silver: 457, gold: 789), accountID: 123456789, isEmployee: false, lastModifiedDate: 0000000000, lastAccessDate: 12345678, reputationChangeYear: 2025, reputationChangeQuarter: 4, reputationChangeMonth: 6, reputationChangeWeek: 2, reputationChangeDay: 4, reputation: 1234567, creationDate: 1234567, userType: .registered, userID: 1234567, acceptRate: nil, location: "UK", websiteURL: "https://google.com", link: "https://google.com", profileImage: nil, displayName: "Lewis"))
        
        users.append(User(badgeCounts: BadgeCounts(bronze: 1234, silver: 457, gold: 789), accountID: 0123456, isEmployee: false, lastModifiedDate: 0000000000, lastAccessDate: 12345678, reputationChangeYear: 2025, reputationChangeQuarter: 4, reputationChangeMonth: 6, reputationChangeWeek: 2, reputationChangeDay: 4, reputation: 1234567, creationDate: 1234567, userType: .registered, userID: 0123456, acceptRate: nil, location: "UK", websiteURL: "https://google.com", link: "https://google.com", profileImage: nil, displayName: "Dan"))
        
        users.append(User(badgeCounts: BadgeCounts(bronze: 1234, silver: 457, gold: 789), accountID: 56789012, isEmployee: false, lastModifiedDate: 0000000000, lastAccessDate: 12345678, reputationChangeYear: 2025, reputationChangeQuarter: 4, reputationChangeMonth: 6, reputationChangeWeek: 2, reputationChangeDay: 4, reputation: 1234567, creationDate: 1234567, userType: .registered, userID: 56789012, acceptRate: nil, location: "UK", websiteURL: "https://google.com", link: "https://google.com", profileImage: nil, displayName: "Lee"))
        
        users.append(User(badgeCounts: BadgeCounts(bronze: 1234, silver: 457, gold: 789), accountID: 456783, isEmployee: false, lastModifiedDate: 0000000000, lastAccessDate: 12345678, reputationChangeYear: 2025, reputationChangeQuarter: 4, reputationChangeMonth: 6, reputationChangeWeek: 2, reputationChangeDay: 4, reputation: 1234567, creationDate: 1234567, userType: .registered, userID: 456783, acceptRate: nil, location: "UK", websiteURL: "https://google.com", link: "https://google.com", profileImage: nil, displayName: "Ben"))
        
        let userData: UserData = UserData(user: users, hasMore: false, quotaMax: 20, quotaRemaining: 19)

        return userData as! T
    }
}
