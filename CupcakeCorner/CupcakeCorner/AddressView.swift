//
//  AddressUIView.swift
//  CupcakeCorner
//
//  Created by joao camargo on 04/06/21.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order : Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Checkout")
                }
            }.disabled(!order.hasValidAddress)
        } .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
