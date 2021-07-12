//
//  QuestionView.swift
//  GayTest
//
//  Created by Serega on 29.06.2021.
//

import SwiftUI
struct LesbianQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var score = 0.0
    @State private var isLesbian = false
    @State private var blurRadius : CGFloat = 0.0
    @State private var result = ""
    @State private var showResult = false
    @State private var isHidden = false
   @State private var questionIndex:Int = 0
 
    func loadHome() {
        DispatchQueue.main.async {
            if(Test.history.count > 100) {
                Test.history.remove(at: 0)
                Test.IsOrientationHistory.remove(at: 0)
            }
            Test.history.append(result)
            Test.IsOrientationHistory.append(isLesbian)
            Test.SaveIsOrientationHistory(orientation: Test.TestOrientation.Lesbian)
            Test.SaveHistory(orientation: Test.TestOrientation.Lesbian)
            self.presentationMode.wrappedValue.dismiss()
                }
    }
    func increment(scoreIncrement: Bool) {
        func addScore() {
            if(scoreIncrement) {
                score+=6.65
            }
        }
        if(questionIndex < 14) {
    questionIndex+=1
            addScore()
        } else {
            addScore()
            let isZero = score == 0.0
            result = isZero ? Test.name +  " (" + String(Test.age) + " years) " + "isn't lesbian" : Test.name +  " (" + String(Test.age) + " years) is " + String(Int(ceil(score))) + "% lesbian"
             isLesbian = !isZero
            score = 0.0
            self.blurRadius = 1.8
            showResult = true
        }
    }
    private var questions: [Question] = [Question(question: "Do you have short nails?", questionImageSource:"short_nails"),
                        Question(question: "Do you want a short haircut?", questionImageSource:"short_haircut"),  Question(question: "Have you ever liked girls?", questionImageSource:"like_girls"), Question(question: "Do you like it when girls kiss?", questionImageSource:"kiss"),
                        Question(question: "Do you support feminism?", questionImageSource:"feminism"), Question(question: "Do you want to go to the pride?", questionImageSource:"pride"), Question(question: "Do you wear rings?", questionImageSource: "rings"),Question(question: "Have you dyed or want to dye your hair?", questionImageSource: "dye_hair"),Question(question: "Do you want to get a tattoo?", questionImageSource: "tatoo"), Question(question: "Do you wear hawaiian shirts?", questionImageSource: "hawaiian_shirts"),
                        Question(question: "Do you wear shoppers?", questionImageSource: "shoppers"),
                        Question(question: "Do you listen to songs by Alyona Shvetz?", questionImageSource: "alyona_shvetz"),
                        Question(question: "Do you like to draw?", questionImageSource: "draw"),  Question(question: "Do you play guitar?", questionImageSource: "guitar"), Question(question: "Can you do makeup?", questionImageSource: "makeup")
                        
    ]
    var body: some View {
        VStack {
            Text(questions[questionIndex].question).font(.system(size: 40)).scaledToFit().minimumScaleFactor(0.2).padding(.top, 20)
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
        }.navigationBarTitle("Question " +  String(questionIndex + 1) + " of 15", displayMode: .inline).alert(isPresented: $showResult) {
            Alert(title: Text("Result"), message: Text(result), primaryButton: .default(Text("OK")) {
                self.blurRadius = 0.0
                self.loadHome()
            }, secondaryButton: .default(Text("Restart")){
                self.blurRadius = 0.0
                questionIndex = 0
                showResult = false
            })
        }.blur(radius: blurRadius)
        
        }
                                            
    
}

struct LesbianQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        LesbianQuestionView()
    }
}
