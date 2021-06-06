//
//  ContentView.swift
//  Bookworm
//
//  Created by joao camargo on 05/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            
            
            List{
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        VStack(alignment: .leading){
                            Text(book.title ?? "Unknow title").font(.headline)
                            Text(book.author ?? "Unknow Author").foregroundColor(.secondary)
                        }
                    }
                }
            }
                .navigationBarTitle("Bookworm")
                .navigationBarItems(trailing: Button(action: {
                                                    self.showingAddScreen.toggle()})  {
                                                            Image(systemName: "plus")
                }).sheet(isPresented: $showingAddScreen){
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
        
    }
}
    
    /// ways of call other view
    //    @State var showingDetail = false
    //
    //    var body: some View {
    //        NavigationView {
    //            VStack(spacing: 20) {
    //            Button(action: {
    //                self.showingDetail.toggle()
    //            }) {
    //                Text("Show Detail")
    //            }.sheet(isPresented: $showingDetail) {
    //                AddBookView()
    //            }
    //
    //
    //                NavigationLink(destination: AddBookView()) {
    //                    Text("Show Detail View")
    //                }.navigationBarTitle("Navigation")
    //            }
    //        }
    //    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
