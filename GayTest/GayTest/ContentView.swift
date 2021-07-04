//
//  ContentView.swift
//  GayTest
//
//  Created by Serega on 29.06.2021.
//
import Combine
import SwiftUI
extension String {
    func isEmpty() -> Bool {
        
        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}
struct ContentView: View {
    @State private var history: [String] = [""]
    @State private var isNavigationBarHidden = true
    @State private var showAlert = false
    @State private var openView = false
    @State private  var name = ""
    @State private var age = ""
    var body: some View {
        NavigationView {
            TabView{
            VStack{
                Text("Gay Test").font(.system(size:  60)).rainbowAnimation()
                TextField("Enter your name", text: $name)
                  .padding(10)
                    .font(.largeTitle)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2)).padding()
                TextField("Enter your age", text: $age)
                  .padding(10)
                    .font(.largeTitle)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2)).padding().onReceive(Just(age)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.age = filtered
                        }
                    }
        Spacer()
                Spacer()
                    Button(action: {
                        if(name.isEmpty() || age.isEmpty()) {
      showAlert = true
                            openView = false
                                        } else {
                                            openView = true
                                            showAlert = false
                                        Test.age = age
                                        Test.name = name
                                            Test.SaveAge()
                                            Test.SaveName()
                                        }
                    }, label: {
                       Text("Start")
                        NavigationLink(destination: QuestionView(), isActive: $openView) {
                            
                        }
                    }).alert(isPresented: $showAlert){ Alert(title: Text("Input name and age"))
                    }
                     .foregroundColor(.white)
                     .padding()
                    .background(Color.blue)
                     .cornerRadius(12).font(.system(size: 35)).padding()
                
            }.tabItem { Text("Test"); Image(systemName: "questionmark.circle")
            }.navigationBarHidden(true)
            VStack {
                List {
                    ForEach(self.history, id: \.self) { string in
                        Text(string)
                }.onDelete { (indexSet) in
                    self.history.remove(atOffsets: indexSet)
                    Test.history = self.history
                     Test.SaveHistory()
                }
                }
            }.tabItem { Text("History")
                Image(systemName: "clock")
            }
            }.navigationBarTitle("History")
        }.onAppear {
            Test.LoadHistory()
            Test.LoadAge()
            Test.LoadName()
            self.history = Test.history
            self.name = Test.name
            self.age = Test.age
        }.navigationBarBackButtonHidden(true).navigationBarHidden(true)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

