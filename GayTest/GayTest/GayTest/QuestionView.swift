//
//  QuestionView.swift
//  GayTest
//
//  Created by Serega on 29.06.2021.
//

import SwiftUI
struct QuestionView: View {
    @State private var result = ""
    @State private var goHome = false
    @State private var showResult = false
    @State private var isHidden = false
   @State private var questionIndex:Int = 0
    func loadHome() {
        DispatchQueue.main.async {
            Test.history.append(result)
            Test.SaveHistory()
            self.goHome = true
                }
    }
    func increment(scoreIncrement: Bool) {
        func addScore() {
            if(scoreIncrement) {
            Test.score+=20
            }
        }
        if(questionIndex < 4) {
    questionIndex+=1
            addScore()
        } else {
            addScore()
            result = Test.score == 0 ? Test.name +  " (" + String(Test.age) + " years) " + "isn't gay" : Test.name +  " (" + String(Test.age) + " years) " + String(Test.score) + "% gay"
            Test.score = 0
            showResult = true
        }
    }
    private var questions: [Question] = [Question(question: "Do you play Brawl Stars?", questionImageSource:"brawl_stars"),
                        Question(question: "AMD or Intel?", questionImageSource:"intel_vs_amd", yesAnswer: "Intel", noAnswer: "AMD"),  Question(question: "Do you use cheats?", questionImageSource:"cheats"), Question(question: "Do you play fortnite?", questionImageSource:"fortnite"),
                        Question(question: "Do you wear pink t-shirt?", questionImageSource:"pinkt_shirt")
    ]
    var body: some View {

        NavigationView {
        VStack {
            NavigationLink(destination: ContentView(), isActive: $goHome,
                              label: { EmptyView() })
            Text(questions[questionIndex].question).font(.system(size: 35))
            Text("Question " +  String(questionIndex + 1) + " of 5").font(.system(size: 35)).padding()
            Spacer()
            Image(questions[questionIndex].questionImageSource).resizable().scaledToFit().padding(.horizontal, 10).clipShape(RoundedRectangle(cornerRadius: 45))

            Spacer()
            Button(action: {
                increment(scoreIncrement: true)
            }) {
                Text(questions[questionIndex].yesAnswer)
                        .fontWeight(.semibold)
                        .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                .foregroundColor(.black)
                        .background(Color.blue)
                        .cornerRadius(20).padding(.horizontal, 20).padding(.vertical, 5)
                
            }
            Button(action: {
                increment(scoreIncrement: false)
            }) {
                Text(questions[questionIndex].noAnswer)
                        .fontWeight(.semibold)
                        .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                        .background(Color.blue)
                        .cornerRadius(20).padding(.horizontal, 20).padding(.vertical, 5)
            }
        }.navigationBarTitle("", displayMode: .inline).alert(isPresented: $showResult) {
            Alert(title: Text("Result"), message: Text(result), primaryButton: .default(Text("OK")) {
                self.loadHome()
            }, secondaryButton: .default(Text("Restart")){
                questionIndex = 0
                showResult = false
            })
        }
        }.navigationBarHidden(true)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
