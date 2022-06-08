//
//  ContentView.swift
//  JuegoGato
//
//  Created by Solidusystems on 08/06/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    func buttonAction(_ index : Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .home)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image("gato")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 300, height: 150)
            Spacer()
            Text("Juego del gato")
                .bold()
                .foregroundColor(Color.white.opacity(0.7))
                .padding(.bottom)
                .font(.title2)
            Spacer()
            ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {self.buttonAction(index)})
                    })
                    
                }
              
            })
            Spacer()
            HStack{
                Image("logonav")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 150, height: 150)
                Spacer()
                Text("Creado: Edgar Guzman")
                    .bold()
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding(.bottom)
                    .font(.title2)
            }
           
        }.alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("FIN DEL JUEGO"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "TU GANASTE!": "PERDISTE PAE!" : "NINGUNO GANO" ) , dismissButton: Alert.Button.destructive(Text("Ok"), action: {
                    self.ticTacToeModel.resetGame()
                  }))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
