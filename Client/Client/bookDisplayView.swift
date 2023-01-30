//
//  bookDisplayView.swift
//  Client
//
//  Created by 高山 on 2023/1/26.
//

import SwiftUI

struct bookDisplayView: View {
    
    @State var books: [String] = [
        "book1", "book2", "book3", "book4", "book5", "book6", "book7", "book8"
    ]
    @State var rt=false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                returnButton
                Spacer()
                Text("library").foregroundColor(.white).font(.largeTitle)
                    .fontWeight(.bold)
                Image(systemName: "books.vertical.fill")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Spacer(minLength: 106)
            }
            VStack{
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
                            HStack{
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
//                .cornerRadius(30)
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
    var returnButton : some View{
        Button(
            action: {
                self.rt.toggle()
            })
        {
            Image(systemName:"arrow.backward.circle")
                .foregroundColor(.white)
                .font(.title3)
        }
        .padding()
    }
    
}

struct bookDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        bookDisplayView()
    }
}
