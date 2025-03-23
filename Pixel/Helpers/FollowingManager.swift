//
//  FollowingManager.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import Foundation

class FollowingManager {
    private let followingKey = "followingList"

    private func getFollowingList() -> [Int] {
        UserDefaults.standard.array(forKey: followingKey) as? [Int] ?? []
    }

    private func saveFollowingList(_ followingList: [Int]) {
        UserDefaults.standard.set(followingList, forKey: followingKey)
    }

    func isFollowing(userId: Int) -> Bool {
        let followingList = getFollowingList()
        return followingList.contains(userId)
    }

    func follow(userId: Int) {
        var followingList = getFollowingList()

        if !followingList.contains(userId) {
            followingList.append(userId)
            saveFollowingList(followingList)
        } else {
            print("User \(userId) is already followed.")
        }
    }

    func unfollow(userId: Int) {
        var followingList = getFollowingList()

        if let index = followingList.firstIndex(of: userId) {
            followingList.remove(at: index)
            saveFollowingList(followingList)
        } else {
            print("User \(userId) is not being followed.")
        }
    }

    func clearAllFollowing() {
        saveFollowingList([])
        print("Following list cleared.")
    }
}
