//
//  ContentView.swift
//  HeroAnimation2
//
//  Created by Al Amin on 30/5/20.
//  Copyright © 2020 Al Amin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var data = [
        
        Card(id: 0, image: "p2", title: "USA", details: "The U.S. is a country of 50 states covering a vast swath of North America, with Alaska in the northwest and Hawaii extending the nation’s presence into the Pacific Ocean. Major Atlantic Coast cities are New York, a global finance and culture center, and capital Washington, DC. Midwestern metropolis Chicago is known for influential architecture and on the west coast, Los Angeles' Hollywood is famed for filmmaking.", expand: false),
        Card(id: 1, image: "p3", title: "Canada", details: "Canada is a country in the northern part of North America. Its ten provinces and three territories extend from the Atlantic to the Pacific and northward into the Arctic Ocean, covering 9.98 million square kilometres, making it the world's second-largest country by total area.", expand: false),
        Card(id: 2, image: "p4", title: "Australia", details: "Australia, officially the Commonwealth of Australia, is a sovereign country comprising the mainland of the Australian continent, the island of Tasmania, and numerous smaller islands. It is the largest country in Oceania and the world's sixth-largest country by total area.", expand: false),
        Card(id: 3, image: "p5", title: "Germany", details: "Germany is a Western European country with a landscape of forests, rivers, mountain ranges and North Sea beaches. It has over 2 millennia of history. Berlin, its capital, is home to art and nightlife scenes, the Brandenburg Gate and many sites relating to WWII. Munich is known for its Oktoberfest and beer halls, including the 16th-century Hofbräuhaus. Frankfurt, with its skyscrapers, houses the European Central Bank.", expand: false),
        Card(id: 4, image: "p6", title: "Dubai", details: "Dubai is a city and emirate in the United Arab Emirates known for luxury shopping, ultramodern architecture and a lively nightlife scene. Burj Khalifa, an 830m-tall tower, dominates the skyscraper-filled skyline. At its foot lies Dubai Fountain, with jets and lights choreographed to music. On artificial islands just offshore is Atlantis, The Palm, a resort with water and marine-animal parks.", expand: false),
        
        Card(id: 5, image: "p1", title: "London", details: "London, the capital of England and the United Kingdom, is a 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic ‘Big Ben’ clock tower and Westminster Abbey, site of British monarch coronations. Across the Thames River, the London Eye observation wheel provides panoramic views of the South Bank cultural complex, and the entire city.", expand: false)
    ]
    @State private var hero = false
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    ForEach(0..<self.data.count){  i in
                        GeometryReader { geometry in
                            CardView(data: self.$data[i], hero: self.$hero)
                                .offset(y: self.data[i].expand ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.hero ? (self.data[i].expand  ? 1 : 0) : 1)
                        }
                        .padding(.horizontal,self.data[i].expand ? 0 : 15)
                        .frame(height: self.data[i].expand ? UIScreen.main.bounds.height: 250)
                        .simultaneousGesture(DragGesture(minimumDistance: self.data[i].expand ? 0 : 500).onChanged({ (_) in
                            print("dragging")
                        }))
                        
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Card : Identifiable {
    
    var id : Int
    var image : String
    var title : String
    var details : String
    var expand : Bool
}

struct CardView: View {
    @Binding var data: Card
    @Binding var hero: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        ZStack (alignment: .topTrailing){
            VStack{
                Image(self.data.image)
                    .resizable()
                    .cornerRadius(self.data.expand ? 0 : 25)
                    .frame(height: self.data.expand ? 350 : 250)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0
                        )) {
                            self.data.expand.toggle()
                            self.hero.toggle()
                        }
                        
                }
                if self.data.expand {
                    VStack(alignment: .leading, spacing: 20){
                        Text(data.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text(data.details)
                            .foregroundColor(.primary).opacity(0.8)
                        Text("Details")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        HStack{
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Image("mcard1")
                            }
                            Spacer(minLength: 0)
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Image("mcard2")
                            }
                            Spacer(minLength: 0)
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Image("mcard3")
                            }
                            Spacer(minLength: 0)
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Image("mcard4")
                            }
                            
                        }
                        
                        
                    }
                    .padding()
                    Spacer(minLength: 0)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Let's Go")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .padding()
                            .background(LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(Capsule())
                        
                    }
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    
                    
                    
                }
                
                
                
                
            }
            if self.data.expand {
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)){
                        self.data.expand.toggle()
                        self.hero.toggle()
                    }
                }) {
                    Image(systemName: "xmark")
                        //.foregroundColor(.white)
                    //.background(colorScheme == .dark ? Color.black : Color.white)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .padding()
                        .frame(width: 30, height: 30)
                        .background(Color.primary)
                        .clipShape(Circle())
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.trailing, 10)
            }
        }
    }
}
