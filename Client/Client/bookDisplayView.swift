//
//  bookDisplayView.swift
//  Client
//
//  Created by 高山 on 2023/1/26.
//

import SwiftUI

struct bookDisplayView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var books: [String] = [
        "book1", "book2", "book3", "book4", "book5", "book6", "book7", "book8",
        "book9", "book10",
    ]

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("library").foregroundColor(.white).font(.largeTitle)
                        .fontWeight(.bold)
                    Image(systemName: "books.vertical.fill")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Spacer()
                }
                VStack {
                    List {
                        Section(
                            header:
                                HStack {
                                    Text("Book Name").foregroundColor(.white)
                                    Image(systemName: "book.fill")
                                        .foregroundColor(.white)
                                }
                                .padding(.bottom)
                                .font(.headline)
                                .foregroundColor(.white)
                        ) {
                            ForEach(books, id: \.self) { book in
                                HStack {
                                    Image(systemName: "text.book.closed.fill")
                                        .foregroundColor(.blue) // .orange
                                        .font(.title2)
                                    Text(book.capitalized)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                        .padding(.vertical)
                                }
                            }
                            //                    .onDelete(perform: delete)
                            //                    .onMove(perform: move)
                            .listRowBackground(Color.white)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.blue)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                }
                //                            .accentColor(.purple)
                //                .listStyle(SidebarListStyle())
                //            .navigationTitle("Book List")
                //            .padding()
                .background(.blue)
            }
            .padding()
            .background(.blue)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.backward.circle")
                    .foregroundColor(.white)
                    .font(.title3)
            })
        )
    }
}

struct bookDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        bookDisplayView()
    }
}
