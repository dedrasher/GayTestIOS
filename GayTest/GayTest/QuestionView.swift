//
//  QuestionView.swift
//  GayTest
//
//  Created by Serega on 29.06.2021.
//

import SwiftUI
struct QuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isGay = false
    @State private var blurRadius : CGFloat = 0.0
    @State private var result = ""
    @State private var showResult = false
    @State private var isHidden = false
   @State private var questionIndex:Int = 0
    func loadHome() {
        DispatchQueue.main.async {
            Test.history.append(result)
            Test.IsGayHistory.append(isGay)
            Test.SaveIsGayHistory()
            Test.SaveHistory()
            self.presentationMode.wrappedValue.dismiss()
                }
    }
    func increment(scoreIncrement: Bool) {
        func addScore() {
            if(scoreIncrement) {
                Test.score+=10
            }
        }
        if(questionIndex < 9) {
    questionIndex+=1
            addScore()
        } else {
            addScore()
            let isZero = Test.score == 0
            result = isZero ? Test.name +  " (" + String(Test.age) + " years) " + "isn't gay" : Test.name +  " (" + String(Test.age) + " years) " + String(Test.score) + "% gay"
             isGay = !isZero
            Test.score = 0
            self.blurRadius = 1.8
            showResult = true
        }
    }
    private var questions: [Question] = [Question(question: "Do you play Brawl Stars?", questionImageSource:"brawl_stars"),
                        Question(question: "AMD or Intel?", questionImageSource:"intel_vs_amd", yesAnswer: "Intel", noAnswer: "AMD"),  Question(question: "Do you use cheats?", questionImageSource:"cheats"), Question(question: "Do you play fortnite?", questionImageSource:"fortnite"),
                        Question(question: "Do you listen Morgenshtern?", questionImageSource:"morgenshtern"), Question(question: "Do you like LGBT?", questionImageSource:"lgbt"), Question(question: "Do you shave your legs?", questionImageSource: "shavelegs"),Question(question: "Do you wear earrings?", questionImageSource: "earrings"),Question(question: "Do you like BLM?", questionImageSource: "blm"), Question(question: "Do you like pop-it?", questionImageSource: "pop-it")]
    var body: some View {

        NavigationView {
        VStack {
            Text(questions[questionIndex].question).font(.system(size: 35)).scaledToFit().minimumScaleFactor(0.5)
            Text("Question " +  String(questionIndex + 1) + " of 10").font(.system(size: 35)).padding()
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
        }.navigationBarHidden(true).alert(isPresented: $showResult) {
            Alert(title: Text("Result"), message: Text(result), primaryButton: .default(Text("OK")) {
                self.blurRadius = 0.0
                self.loadHome()
            }, secondaryButton: .default(Text("Restart")){
                self.blurRadius = 0.0
                questionIndex = 0
                showResult = false
            })
        }
        }.navigationBarBackButtonHidden(true).navigationBarHidden(true).blur(radius: blurRadius)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
