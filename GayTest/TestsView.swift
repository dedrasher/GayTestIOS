//
//  TestsView.swift
//  GayTest
//
//  Created by Serega on 11.07.2021.
//

import SwiftUI

struct TestsView: View {
    @State private var openGayTest = false
    @State private var openLesbianTest = false
    var body: some View {
        NavigationView{
            List{
                ZStack {
                    Image("Gay").resizable().scaledToFit().cornerRadius(15.0).padding().onTapGesture {
                        openGayTest = true
                    }.background(  NavigationLink(
                        destination: MainGayView(),
                        isActive: $openGayTest){
                        EmptyView()
                    }.frame(width: 0, height: 0)
                    .hidden())
                    VStack {
                        Spacer()
                        HStack{
                            Text("Gay Test").font(.largeTitle).padding(.bottom,20).padding(.leading, 30).foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
                    ZStack {
                        Image("lesbian").resizable().scaledToFit().cornerRadius(15.0).padding().onTapGesture {
                            openLesbianTest = true
                        }.background(  NavigationLink(
                            destination: MainLesbianView(),
                            isActive: $openLesbianTest){
                            EmptyView()
                        }.frame(width: 0, height: 0)
                        .hidden())
                        VStack {
                            Spacer()
                            HStack{
                                Text("Lesbian Test").font(.largeTitle).padding(.bottom,20).padding(.leading, 30).foregroundColor(.white)
                                Spacer()
                            }
                        }
                    }
            }.navigationBarTitle("Tests")
        }
      
    }
}

struct TestsView_Previews: PreviewProvider {
    static var previews: some View {
        TestsView()
    }
}
