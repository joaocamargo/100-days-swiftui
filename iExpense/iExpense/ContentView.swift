//
//  ContentView.swift
//  iExpense
//
//  Created by joao camargo on 28/05/21.
//

import SwiftUI


struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
}


struct ContentView: View {
    @ObservedObject private var expenses = Expenses()
    @State private var showingAddExpensse = false
    
    var totalAmount: Int {
        var soma = 0
        
        for i in expenses.items {
            soma += i.amount
        }
        return soma
    }
    
    
    var body: some View {
        
        NavigationView{
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type).font(.subheadline)
                            }
                            Spacer()
                            Text(String(item.amount)).foregroundColor(item.amount < 200 ? .black : .red)
                        }
                    }.onDelete(perform: removeItems)
                    
                }.navigationBarTitle("iExpense")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.showingAddExpensse = true
                                        }) {
                                            Image(systemName: "plus")
                                        }).sheet(isPresented: $showingAddExpensse) {
                                            AddView(expenses: self.expenses)
                                        }
                HStack {
                    Text("Total:").font(.subheadline)
                    Spacer()
                    Text("\(self.totalAmount)")
                }.padding().foregroundColor(.red)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
