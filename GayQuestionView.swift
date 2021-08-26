//
//  QuestionView.swift
//  GayTest
//
//  Created by Serega on 29.06.2021.
//

import SwiftUI
struct GayQuestionView: View {
    enum Answer{
       case yes
        case no
        case unknown
    }
    @Environment(\.presentationMode) var presentationMode
    @State
    var answers = [Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown,Answer.unknown]
    @State private var score = 0.0
    @State private var isGay = false
    @State private var blurRadius : CGFloat = 0.0
    @State private var result = ""
    @State private var showResult = false
    @State private var isHidden = false
 
    func loadHome() {
        DispatchQueue.main.async {
            if(Test.history.count > 100) {
                Test.history.remove(at: 0)
                Test.IsOrientationHistory.remove(at: 0)
            }
            Test.history.append(result)
            Test.IsOrientationHistory.append(isGay)
            Test.SaveIsOrientationHistory(orientation: Test.TestOrientation.gay)
            Test.SaveHistory(orientation: Test.TestOrientation.gay)
            self.presentationMode.wrappedValue.dismiss()
                }
    }
    func answeredQuestionsCount() -> Int{
        var count = 0
        for answer in answers {
            if answer != Answer.unknown {
                count+=1
            }
        }
        return count
    }
    func isAllQuestionsAnswered() -> Bool {
        return !answers.contains(Answer.unknown)
    }
    func countResult() {
        for answer in answers {
            if answer == Answer.yes {
                score += 6.65
            }
        }
            let isZero = score == 0.0
            if (isZero) {
                result =    Test.name +  " (" + String(Test.age) + " years) " + "isn't gay"
            } else {
                result = Test.name +  " (" + String(Test.age) + " years) is " + String(Int(ceil(score))) + "% gay"
            }
             isGay = !isZero
            score = 0.0
            self.blurRadius = 1.8
            showResult = true
    }
    private var questions: [Question] = [Question(question: "Do you play Brawl Stars?", questionImageSource:"brawl_stars"),
                        Question(question: "AMD or Intel?", questionImageSource:"intel_vs_amd", yesAnswer: "Intel", noAnswer: "AMD"),  Question(question: "Do you use cheats?", questionImageSource:"cheats"), Question(question: "Do you play fortnite?", questionImageSource:"fortnite"),
                        Question(question: "Do you listen Morgenshtern?", questionImageSource:"morgenshtern"), Question(question: "Do you like LGBT?", questionImageSource:"lgbt"), Question(question: "Do you shave your legs?", questionImageSource: "shavelegs"),Question(question: "Do you wear earrings?", questionImageSource: "earrings"),Question(question: "Do you like BLM?", questionImageSource: "blm"), Question(question: "Do you like pop-it?", questionImageSource: "pop-it"),
                        Question(question: "Do you like hugging man?", questionImageSource: "hugs"),
                        Question(question: "Do you like camping in games?", questionImageSource: "camping"),
                        Question(question: "Are you toxic player?", questionImageSource: "toxic"),  Question(question: "Do you play like a snake in PUBG?", questionImageSource: "snake"), Question(question: "Do you like pink color?", questionImageSource: "pink")
                        
    ]
    var body: some View {
        ScrollViewReader { view in
        ScrollView {
            ForEach(questions.indices) { i in
        VStack {
            Text(questions[i].question).font(.system(size: 40)).scaledToFit().minimumScaleFactor(0.2).padding(.top, 20)
            Image(questions[i].questionImageSource).resizable().scaledToFit().padding(.horizontal, 10).clipShape(RoundedRectangle(cornerRadius: 45))
            HStack {
            Button(action: {
                answers[i] = Answer.yes
                if isAllQuestionsAnswered() {
                    countResult()
                }
            }) {
                Text(questions[i].yesAnswer)
                        .fontWeight(.semibold)
                        .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                .foregroundColor(.black)
                .background(answers[i] == Answer.yes  ? Color.gray : Color.blue)
                        .cornerRadius(20).padding(.horizontal, 10).padding(.vertical, 5)
                
            }
            Button(action: {
                answers[i] = Answer.no
                if isAllQuestionsAnswered() {
                    countResult()
                }
            }) {
                Text(questions[i].noAnswer)
                        .fontWeight(.semibold)
                        .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(answers[i] == Answer.no ? Color.gray : Color.blue)
                        .cornerRadius(20).padding(.horizontal, 10).padding(.vertical, 5)
            }
            }
        }.toolbar{
            ToolbarItem(placement: .principal){
                Text("Answered questions: " + String(answeredQuestionsCount()) + " of 15").scaledToFill().blur(radius: blurRadius)

            }
        }.alert(isPresented: $showResult) {
            Alert(title: Text("Result"), message: Text(result), primaryButton: .default(Text("OK")) {
                self.blurRadius = 0.0
                self.loadHome()
            }, secondaryButton: .default(Text("Restart")){
                self.blurRadius = 0.0
                for i in answers.indices{
                    answers[i] = Answer.unknown
                }
                withAnimation {
                view.scrollTo(0)
                }
            })
        }.blur(radius: blurRadius).id(i)
        }
        }
        }
        }
                                            
    
}

struct GayQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        GayQuestionView()
    }
}
