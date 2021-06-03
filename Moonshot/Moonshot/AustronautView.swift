//
//  AustronautView.swift
//  Moonshot
//
//  Created by joao camargo on 03/06/21.
//

import SwiftUI

struct AustronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id).resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description).padding().layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AustronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts")
    
    
    static var previews: some View {
        AustronautView(astronaut: astronauts[0])
    }
}
