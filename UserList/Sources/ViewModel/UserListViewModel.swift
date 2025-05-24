//
//  UserListViewModel.swift
//  UserList
//
//  Created by Renaud Leroy on 18/04/2025.
//

import Foundation
import SwiftUI

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var isGridView = false
    
    private let repository: UserListRepository
    init(repository: UserListRepository) {
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }
    
    // MARK: - Inputs
    @MainActor
    func fetchUsers() async {
        isLoading = true
        do {
            let users = try await repository.fetchUsers(quantity: 20)
            self.users.append(contentsOf: users)
            
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    @MainActor
    func reloadUsers() async {
        users.removeAll()
        await fetchUsers()
    }
}






