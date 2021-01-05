//
//  ContentView.swift
//  XO
//
//  Created by Mac on 1/5/21.
//

import SwiftUI

struct field{
    var player: String
    var enable : Bool
}

struct ContentView: View {
    
    @State var Fields : [[field]] = .init(repeating: .init(repeating: field(player: "", enable: true), count: 3), count:3)
    @State var playTurn : String = "X"
    @State var winner = ""
    @State var winStatus = false
    @State var drawCounter = 0
    
    var body: some View {
        VStack(spacing: 10){
            Text("\(playTurn)'s Turn)").padding().foregroundColor(.white)
            ForEach(0 ..< 3){r in
                HStack(spacing:10){
                    ForEach(0 ..< 3){c in
                     
                        Button(action: {
                            if Fields[r][c].enable{
                                
                                Fields[r][c].player = playTurn
                                
                                drawCounter += 1
                                checkWinner()
                                if winStatus == false {
                                    playTurn = playTurn == "X" ? "O" : "X"
                                    Fields[r][c].enable = false
                                }else{
                                    Fields[0][0].enable = false
                                    Fields[0][1].enable = false
                                    Fields[0][2].enable = false
                                    Fields[1][0].enable = false
                                    Fields[1][1].enable = false
                                    Fields[1][2].enable = false
                                    Fields[2][0].enable = false
                                    Fields[2][1].enable = false
                                    Fields[2][2].enable = false
                                }
                            }
                        }, label: {
                            Text(Fields[r][c].player)
                                .font(.system(size: 60))
                                .foregroundColor(Color.black)
                                .frame(width: 90 , height: 90 , alignment: .center)
                                .background(Color.white)
                            
                        })
                }
                
            }
        }
            
            
            
            if winStatus == true{
                Text("\(winner)' win").padding().foregroundColor(.white)
            Button(action: {
                restart()
            }, label: {
                Text("Restart Game")
            }).padding().background(Color.gray).foregroundColor(.white)
            }
        }.background(Color.black).padding()
        
}
    func checkWinner(){
        let r1 = Fields[0][0].player == playTurn && Fields[0][1].player == playTurn && Fields[0][2].player == playTurn
        
        let r2 = Fields[1][0].player == playTurn && Fields[1][1].player == playTurn && Fields[1][2].player == playTurn
        
        let r3 = Fields[2][0].player == playTurn && Fields[2][1].player == playTurn && Fields[2][2].player == playTurn
        
        let c1 = Fields[0][0].player == playTurn && Fields[1][0].player == playTurn && Fields[2][0].player == playTurn
        
        let c2 = Fields[0][1].player == playTurn && Fields[1][1].player == playTurn && Fields[2][1].player == playTurn
        
        let c3 = Fields[0][2].player == playTurn && Fields[1][2].player == playTurn && Fields[2][2].player == playTurn
        
        let d1 = Fields[0][0].player == playTurn && Fields[1][1].player == playTurn && Fields[2][2].player == playTurn
        let d2 = Fields[0][2].player == playTurn && Fields[1][1].player == playTurn && Fields[2][0].player == playTurn
        
        if r1 || r2 || r3 || c1 || c2 || c3 || d1 || d2{
            winner = "\(playTurn)"
            winStatus = true
        }else if drawCounter == 9{
            winner = "Draw"
            winStatus = true
        }
    }
    func restart(){
         Fields = .init(repeating: .init(repeating: field(player: "", enable: true), count: 3), count:3)
         playTurn = "X"
         winner = ""
         winStatus = false
         drawCounter = 0
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
