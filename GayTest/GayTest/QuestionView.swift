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
    func setNavigationBarAppearanceToDefault() {
        UINavigationBar.appearance().shadowImage = nil
        UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
    }
    func loadHome() {
        DispatchQueue.main.async {
            if(Test.history.count > 100) {
                Test.history.remove(at: 0)
                Test.IsGayHistory.remove(at: 0)
            }
            Test.history.append(result)
            Test.IsGayHistory.append(isGay)
            Test.SaveIsGayHistory()
            Test.SaveHistory()
            setNavigationBarAppearanceToDefault()
            self.presentationMode.wrappedValue.dismiss()
                }
    }
    func increment(scoreIncrement: Bool) {
        func addScore() {
            if(scoreIncrement) {
                Test.score+=6.65
            }
        }
        if(questionIndex < 14) {
    questionIndex+=1
            addScore()
        } else {
            addScore()
            let isZero = Test.score == 0.0
            result = isZero ? Test.name +  " (" + String(Test.age) + " years) " + "isn't gay" : Test.name +  " (" + String(Test.age) + " years) is " + String(Int(ceil(Test.score))) + "% gay"
             isGay = !isZero
            Test.score = 0.0
            self.blurRadius = 1.8
            showResult = true
        }
    }
    private var questions: [Question] = [Question(question: "Do you play Brawl Stars?", questionImageSource:"brawl_stars"),
                        Question(question: "AMD or Intel?", questionImageSource:"intel_vs_amd", yesAnswer: "Intel", noAnswer: "AMD"),  Question(question: "Do you use cheats?", questionImageSource:"cheats"), Question(question: "Do you play fortnite?", questionImageSource:"fortnite"),
                        Question(question: "Do you listen Morgenshtern?", questionImageSource:"morgenshtern"), Question(question: "Do you like LGBT?", questionImageSource:"lgbt"), Question(question: "Do you shave your legs?", questionImageSource: "shavelegs"),Question(question: "Do you wear earrings?", questionImageSource: "earrings"),Question(question: "Do you like BLM?", questionImageSource: "blm"), Question(question: "Do you like pop-it?", questionImageSource: "pop-it"),
                        Question(question: "Do you like hugging man?", questionImageSource: "hugs"),
                        Question(question: "Do you like camping in games?", questionImageSource: "camping"),
                        Question(question: "Are you toxic player?", questionImageSource: "toxic"),  Question(question: "Do you play like a snake in PUBG?", questionImageSource: "snake"), Question(question: "Do you like pink color?", questionImageSource: "pink")
                        
    ]
    var body: some View {

        NavigationView {
        VStack {
            Text(questions[questionIndex].question).font(.system(size: 35)).scaledToFit().minimumScaleFactor(0.5)
            Text("Question " +  String(questionIndex + 1) + " of 15").font(.system(size: 35)).padding()
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
        }.toolbar{
            ToolbarItem(placement:.navigationBarLeading) {
                Button(action: {
                    Test.score = 0.0
                    setNavigationBarAppearanceToDefault()
                        self.presentationMode.wrappedValue.dismiss()
                }
                ) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Menu").font(.system(size:20)).minimumScaleFactor(0.5).scaledToFit()
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline).alert(isPresented: $showResult) {
            Alert(title: Text("Result"), message: Text(result), primaryButton: .default(Text("OK")) {
                self.blurRadius = 0.0
                self.loadHome()
            }, secondaryButton: .default(Text("Restart")){
                self.blurRadius = 0.0
                questionIndex = 0
                showResult = false
            })
        }
        }.blur(radius: blurRadius).navigationBarBackButtonHidden(true).navigationBarHidden(true).onAppear{
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
                                            
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
