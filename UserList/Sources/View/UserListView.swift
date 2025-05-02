//
//  UserListView.swift
//  UserList
//
//  Created by Renaud Leroy on 02/05/2025.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel = UserListViewModel(repository: UserListRepository())

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isGridView {
                    UserGridListView()
                }
                else {
                    UserClassicListView()
                }
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker(selection: $viewModel.isGridView, label: Text("Display")) {
                        Image(systemName: "rectangle.grid.1x2.fill")
                            .tag(true)
                            .accessibilityLabel(Text("Grid view"))
                        Image(systemName: "list.bullet")
                            .tag(false)
                            .accessibilityLabel(Text("List view"))
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
//                        self.viewModel.reloadUsers()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.large)
                    }
                }
            }
            .task {
                await viewModel.fetchUsers()
                UserClassicListView()
            }

        }
    }
}


#Preview {
    UserListView()
}
