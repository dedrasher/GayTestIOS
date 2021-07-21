//
//  ContentView.swift
//  GayTest
//
//  Created by Serega on 29.06.2021.
//
import Combine
import SwiftUI
struct MainLesbianView: View {
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
        VStack {
            TabView(selection: $selectedTab){
            VStack{
                Text("Lesbian Test").font(.system(size:  60)).rainbowAnimation().padding(-1)
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
                    
                                        } else {
                                            openView = true
                                            showAlert = false
                                        Test.age = age
                                        Test.name = name
                                            Test.SaveAge(orientation: Test.TestOrientation.Lesbian)
                                            Test.SaveName(orientation: Test.TestOrientation.Lesbian)
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }
                    }, label: {
                       Text("Start")
                        NavigationLink(destination: LesbianQuestionView(), isActive: $openView) {
                            
                        }
                    }).alert(isPresented: $showAlert){ Alert(title: Text("Input name and age"))
                    }
                     .foregroundColor(.white)
                     .padding()
                    .background(Color.blue)
                     .cornerRadius(12).font(.system(size: 35)).padding()
                
            }.tabItem { Text("Test"); Image(systemName: "questionmark.circle")
            }.tag(0)
            VStack {
                if Test.IsHistoryEmpty {
                    Text("No passed tests yet!").font(.system(size:  60)).scaledToFit().minimumScaleFactor(0.5)
                } else {
                    
                List{
                    ForEach(self.history.indices, id: \.self) { index in
                        if(searchMode == 2) {
                        Text(self.history[index])
                        } else if(searchMode == 0 && Test.IsOrientationHistory[index]) {
                            Text(self.history[index])
                        } else if(searchMode == 1 && !Test.IsOrientationHistory[index]) {
                            Text(self.history[index])
                        }
                }.onDelete { (indexSet) in
                    self.history.remove(atOffsets: indexSet)
                    Test.history = self.history
                    Test.IsOrientationHistory.remove(atOffsets: indexSet)
                    Test.SaveIsOrientationHistory(orientation: Test.TestOrientation.Lesbian)
                     Test.SaveHistory(orientation: Test.TestOrientation.Lesbian)
                }
                }.animation(.default)
                    
                }
            }.tabItem { Text("History")
                Image(systemName: "clock")
            }.tag(1)
            }.alert(isPresented: $showAlertDeleteHistory) {
                Alert(title: Text("Delete history?"), primaryButton: .destructive(Text("Yes")) {
                    history.removeAll()
                    Test.history = history
                    Test.IsOrientationHistory.removeAll()
                    Test.SaveHistory(orientation: Test.TestOrientation.Lesbian)
                    Test.SaveIsOrientationHistory(orientation: Test.TestOrientation.Lesbian)
                },secondaryButton: .default(Text("No")){})
            }
        }.onAppear {
            Test.LoadHistory(orientation: Test.TestOrientation.Lesbian)
            Test.LoadIsOrientationHistory(orientation: Test.TestOrientation.Lesbian)
            Test.LoadAge(orientation: Test.TestOrientation.Lesbian)
            Test.LoadName(orientation: Test.TestOrientation.Lesbian)
            self.history = Test.history
            self.name = Test.name
            self.age = Test.age
        }.navigationBarTitle("Menu", displayMode: .inline).toolbar{
            ToolbarItem(placement:  ToolbarItemPlacement.principal) {
                if selectedTab == 1 && !Test.IsHistoryEmpty{
                Picker("Search", selection: $searchMode) {
                   
                                        Text("Lesbi").tag(0)
                                        Text("Not lesbi").tag(1)
                    Text("All").tag(2)
                    
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            ToolbarItem {
                if selectedTab == 1 && !Test.IsHistoryEmpty {
                Button(action: {
                    self.showAlertDeleteHistory = true
                }) {
                    Image(systemName: "trash")
                }
                }
            }
        }
    }
    }
struct MainLesbianView_Previews: PreviewProvider {
    static var previews: some View {
        MainLesbianView()
    }
}
