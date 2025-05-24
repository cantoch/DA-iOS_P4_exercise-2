//
//  MockData.swift
//  UserList
//
//  Created by Renaud Leroy on 09/05/2025.
//

import Foundation
@testable import UserList

class MockData {
    
    // MARK: - Properties
    
    let mockUser1: UserListResponse.User
    let mockUser2: UserListResponse.User
    let userListResponseMock: UserListResponse
    var isValidResponse: Bool = true
    
    // MARK: - Init
    
    init() {
        self.mockUser1 = UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mr", first: "John", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1990-01-01", age: 31),
            picture: UserListResponse.User.Picture(
                large: "https://example.com/large.jpg",
                medium: "https://example.com/medium.jpg",
                thumbnail: "https://example.com/thumbnail.jpg"
            )
        )
        
        self.mockUser2 = UserListResponse.User(
            name: UserListResponse.User.Name(title: "Ms", first: "Jane", last: "Smith"),
            dob: UserListResponse.User.Dob(date: "1995-02-15", age: 26),
            picture: UserListResponse.User.Picture(
                large: "https://example.com/large.jpg",
                medium: "https://example.com/medium.jpg",
                thumbnail: "https://example.com/thumbnail.jpg"
            )
        )
        
        self.userListResponseMock = UserListResponse(results: [mockUser1, mockUser2])
    }
    
    // MARK: - Methods
    
    private func encodeData(userListResponseType: UserListResponse) throws -> Data {
        return try JSONEncoder().encode(userListResponseType)
    }
    
    func executeRequest(request: URLRequest) async throws -> (Data, URLResponse) {
        if isValidResponse {
            return try await validMockResponse(request: request)
        } else {
            return try await invalidMockResponse(request: request)
        }
    }
    
    private func validMockResponse(request: URLRequest) async throws -> (Data, URLResponse) {
        let data = try encodeData(userListResponseType: userListResponseMock)
        let validResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (data, validResponse)
    }
    
    private func invalidMockResponse(request: URLRequest) async throws -> (Data, URLResponse) {
        let invalidData = "JSONCASSÉ".data(using: .utf8)!
        let invalidResponse = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        return (invalidData, invalidResponse)
    }
}
