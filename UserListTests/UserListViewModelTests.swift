//
//  UserListViewModelTests.swift
//  UserListTests
//
//  Created by Renaud Leroy on 09/05/2025.
//

import XCTest
@testable import UserList

final class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockData = MockData()
    var repository: UserListRepository!
    
    override func setUp() {
        super.setUp()
        mockData.isValidResponse = true
        repository = UserListRepository(executeDataRequest: mockData.executeRequest)
        viewModel = UserListViewModel(repository: repository)
    }
    
    override func tearDown() {
        viewModel = nil
        repository = nil
        super.tearDown()
    }
    
    func testShouldLoadMoreData() async {
        // Given
        await viewModel.fetchUsers()
        let currentUser = viewModel.users.last!
        
        // When
        let shouldLoadMore = viewModel.shouldLoadMoreData(currentItem: currentUser)
        
        // Then
        XCTAssertTrue(shouldLoadMore)
    }
    
    func testShouldNotLoadMoreData() async {
        // Given
        await viewModel.fetchUsers()
        let currentUser = viewModel.users.first!
        
        // When
        let shouldLoadMore = viewModel.shouldLoadMoreData(currentItem: currentUser)
        
        // Then
        XCTAssertFalse(shouldLoadMore)
    }
    
    func testReloadUsers() async {
        // Given
        await viewModel.fetchUsers()
        let initialUserCount = viewModel.users.count
        XCTAssert(initialUserCount == 2)
        
        // When
        await viewModel.reloadUsers()
        
        // Then
        let reloadedUserCount = viewModel.users.count
        XCTAssert(reloadedUserCount == 2)
    }
}
