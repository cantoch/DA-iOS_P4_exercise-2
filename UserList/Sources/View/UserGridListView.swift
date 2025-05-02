//
//  UserGridListView.swift
//  UserList
//
//  Created by Renaud Leroy on 02/05/2025.
//

import SwiftUI

struct UserGridListView: View {
    
    @StateObject private var viewModel = UserListViewModel(repository: UserListRepository())

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        VStack {
                            AsyncImage(url: URL(string: user.picture.medium)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                            }
                            
                            Text("\(user.name.first) \(user.name.last)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                    }
//                    .onAppear {
////                        if self.viewModel.shouldLoadMoreData(currentItem: user) {
//                            self.viewModel.fetchUsers()
////                        }
//                    }
                }
            }
        }
    }
}

