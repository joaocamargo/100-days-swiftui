//
//  ContentView.swift
//  Bookworm
//
//  Created by joao camargo on 05/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) {   student in
                    Text(student.name ?? "Unknow")
                    
                }
            }
            
            Button("Add"){
                let firstNames = ["Joao","Andressa","joao 2","Rafaela"]
                let lastnames = ["Paim","Borges","Carvalho","Camargo"]
                
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastnames.randomElement()!
                
                let student = Student(context:  self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? self.moc.save()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
