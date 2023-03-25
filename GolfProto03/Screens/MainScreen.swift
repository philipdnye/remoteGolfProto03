//
//  HomeScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 23/03/2023.
//

import SwiftUI

struct MainScreen: View {

    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(.orange)]
       
    }
    var body: some View {
        TabView{
            
            
            
            
            
            NavigationStack{
                ClubListScreen()
                
                    .navigationBarTitle("Clubs")
                    .navigationBarTitleDisplayMode(.inline)
//                    .toolbarRole(.editor)
                //                    .embedInNavigationView()
                //                .navigationViewStyle(.stack)
            }
                .tabItem{
                    Label("Clubs", systemImage:"flag.fill")
                }
            
            
            NavigationStack{
                PlayerListScreen()
                
                    .navigationBarTitle("Players")
                    .navigationBarTitleDisplayMode(.inline)
//                    .toolbarRole(.editor)
                //                    .embedInNavigationView()
                //                .navigationViewStyle(.stack)
            }
                .tabItem{
                    Label("Players", systemImage:"person.fill")
                }

            
            
        }
        .accentColor(.orange)

    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MainScreen()
        }
    }
}

