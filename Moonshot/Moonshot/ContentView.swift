//
//  ContentView.swift
//  Moonshot
//
//  Created by joao camargo on 30/05/21.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView{
            List(missions) { mission in
                NavigationLink(destination: Text("Detail View")){
                    Image(mission.image).resizable().scaledToFit().frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName).font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }                
            }.navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
