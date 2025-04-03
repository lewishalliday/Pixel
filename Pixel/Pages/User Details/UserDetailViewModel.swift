//
//  UserDetailViewModel.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-04-02.
//

class UserDetailViewModel {
    let user: User
    let followingManager = FollowingManager()
    
    init(user: User) {
        self.user = user
    }
    
    func isFollowingUser() -> Bool {
        followingManager.isFollowing(userId: user.accountID)
    }
    
    func toggleFollowingState(completionHander: @escaping (Bool) -> Void) {
        if isFollowingUser() {
            followingManager.unfollow(userId: user.accountID)
            completionHander(false)
        } else {
            followingManager.follow(userId: user.accountID)
            completionHander(true)
        }
    }
}
