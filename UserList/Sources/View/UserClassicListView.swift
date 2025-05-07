//
//  UserClassicListView.swift
//  UserList
//
//  Created by Renaud Leroy on 02/05/2025.
//

import SwiftUI

struct UserClassicListView: View {
    
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        List(viewModel.users) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
                HStack {
                    AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(user.name.first) \(user.name.last)")
                            .font(.headline)
                        Text("\(user.dob.date)")
                            .font(.subheadline)
                    }
                }
            }
            .onAppear {
                if self.viewModel.shouldLoadMoreData(currentItem: user) {
                    Task {
                        await self.viewModel.fetchUsers()
                    }
                }
            }
        }
    }
}

