//
//  ContentView.swift
//  Memorize
//
//  Created by Kieran Hitchcock on 31/01/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "🚀", "💩", "😀", "😀", "😀", "😀"]
    @State var count = 3
    var body: some View {
        VStack{
            ScrollView {
                cards
            }
            cardAdjusters
        }.padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    
    func cardAdjusterBuilder(by offset: Int, symbol: String) -> some View {
        return Button(action: {
            count += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(count + offset < 1 || count + offset > emojis.count)
    }
    
    var cardAdder: some View {
        cardAdjusterBuilder(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    var cardRemover: some View {
        cardAdjusterBuilder(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdjusters: some View {
        HStack {
            Spacer()
            cardRemover
            Spacer()
            Spacer()
            cardAdder
            Spacer()
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View{
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.title)
            }.opacity(isFaceUp ? 0 : 1)
            
            base.fill().opacity(isFaceUp ? 1 : 0)
                
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
