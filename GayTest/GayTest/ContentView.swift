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
    @State private var showAlertDeleteHistory = false
    @State private var searchMode: Int = 2
    @State private var selectedTab = 0
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
                if Test.IsHistoryEmpty {
                    Text("No passed tests yet!").font(.system(size:  60)).scaledToFit().minimumScaleFactor(0.5)
                } else {
                List {
                    ForEach(self.history.indices, id: \.self) { index in
                        if(searchMode == 2) {
                        Text(self.history[index])
                        } else if(searchMode == 0 && Test.IsGayHistory[index]) {
                            Text(self.history[index])
                        } else if(searchMode == 1 && !Test.IsGayHistory[index]) {
                            Text(self.history[index])
                        }
                }.onDelete { (indexSet) in
                    self.history.remove(atOffsets: indexSet)
                    Test.history = self.history
                    Test.IsGayHistory.remove(atOffsets: indexSet)
                    Test.SaveIsGayHistory()
                     Test.SaveHistory()
                }
                }.animation(.default)
                }
            }.navigationBarHidden(selectedTab == 0 || Test.IsHistoryEmpty).tabItem { Text("History")
                Image(systemName: "clock")
            }.tag(1)
            }.toolbar{
                ToolbarItemGroup(placement:  ToolbarItemPlacement.principal) {
                    Picker("Search", selection: $searchMode) {
                                            Text("Gay").tag(0)
                                            Text("Not gay").tag(1)
                        Text("All").tag(2)
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                }
                ToolbarItemGroup {
                    Button(action: {
                        self.showAlertDeleteHistory = true
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }.navigationBarTitle("History").onAppear{
                self.history = Test.history
            }.alert(isPresented: $showAlertDeleteHistory) {
                Alert(title: Text("Delete history?"), primaryButton: .destructive(Text("Yes")) {
                    history.removeAll()
                    Test.history = history
                    Test.IsGayHistory.removeAll()
                    Test.SaveHistory()
                    Test.SaveIsGayHistory()
                },secondaryButton: .default(Text("No")){})
            }
        }.onAppear {
            Test.LoadHistory()
            Test.LoadIsGayHistory()
            Test.LoadAge()
            Test.LoadName()
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

