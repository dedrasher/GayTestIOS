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
    enum SearchOptions {
        case gay, notgay, all
    }
    @State private var selectedTab = 0
    @State private var searchOptions = SearchOptions.all
    @State private var history: [String] = [""]
    @State private var isNavigationBarHidden = true
    @State private var showAlert = false
    @State private var openView = false
    @State private  var name = ""
    @State private var age = ""
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab){
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
                             UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                
            }.navigationBarHidden(true).tabItem { Text("Test"); Image(systemName: "questionmark.circle")
            }.tag(0)
            VStack {
                List {
                    ForEach(self.history.indices, id: \.self) { index in
                        if(searchOptions == SearchOptions.all) {
                        Text(self.history[index])
                        } else if(searchOptions == SearchOptions.gay && Test.IsGayHistory[index]) {
                            Text(self.history[index])
                        } else if(searchOptions == SearchOptions.notgay && !Test.IsGayHistory[index]) {
                            Text(self.history[index])
                        }
                }.onDelete { (indexSet) in
                    self.history.remove(atOffsets: indexSet)
                    Test.history = self.history
                    Test.IsGayHistory.remove(atOffsets: indexSet)
                    Test.SaveIsGayHistory()
                     Test.SaveHistory()
                }
                }
            }.tabItem { Text("History")
                Image(systemName: "clock")
            }.tag(1)
            }.navigationBarHidden(selectedTab == 0 || history.count == 0).navigationBarItems(leading:Button(searchOptions != SearchOptions.gay ? "Gay" : "All") {
                if(searchOptions == SearchOptions.gay) {
                searchOptions = SearchOptions.all
                }else {
                searchOptions = SearchOptions.gay
                }
            } , trailing: Button(searchOptions != SearchOptions.notgay ? "Not gay" : "All") {
                if(searchOptions == SearchOptions.notgay) {
                searchOptions = SearchOptions.all
                }else {
                    searchOptions = SearchOptions.notgay
                }
            }).navigationBarTitle("History")
        }.onAppear {
            Test.LoadHistory()
            Test.LoadIsGayHistory()
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

