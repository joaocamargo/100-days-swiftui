//
//  DetailView.swift
//  Bookworm
//
//  Created by joao camargo on 06/06/21.
//
import CoreData
import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentaionMode
    
    @State private var showindDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing){
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "Fantasy")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                    
                }
                Text(self.book.author ?? "Unknow Author").font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No Review").padding()
                
                RatingView(rating: .constant(Int(self.book.rating))).font(.largeTitle)
                
                Spacer()
                
            }
        }.navigationBarTitle(Text(book.title ?? "Unknow book"),displayMode: .inline)
        .alert(isPresented: $showindDeleteAlert){ Alert(title: Text("Delete Book"),message: Text("Are you sure"), primaryButton: .destructive(Text("Delete")) {
            self.deleteBook()
        }, secondaryButton: .cancel())
        }.navigationBarItems(trailing: Button(action: {
                                                self.showindDeleteAlert = true }){
            Image(systemName: "trash")
        })
    }
    
    func deleteBook(){
        moc.delete(book)
        try? moc.save()
        presentaionMode.wrappedValue.dismiss()
    }
    
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "text book"
        book.author = "Joao"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
