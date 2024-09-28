//
//  ContentView.swift
//  Multiplication table
//
//  Created by Никита Мартьянов on 9.02.24.
//

import SwiftUI

struct ContentView: View {
    @State private var answer = ""
    @State private var numberOfQuestion = 5
    @State private var number1 = 2
    @State private var number2 = 0
    @State private var score = 0
    @State private var round = 0
    
    @State private var isShowingAlert = false
    @State private var isOption = false
    @State private var start = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.yellow,.blue], startPoint: .bottomLeading, endPoint: .topLeading)
                .ignoresSafeArea()
            if start {
                
                if isOption {
                    
                    VStack(spacing: 30) {
                        
                        Text("Сколько будет умножить \(number1) х \(number2)")
                            .padding()
                            .background(.green)
                            .font(.headline)
                        
                        TextField("Ответ", text: $answer)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button("Ответить") {
                            checkAnswer()
                            nextQuestion()
                            final()
                        }
                        .padding(30)
                        .background(.green)
                        .foregroundStyle(.black)
                        .font(.headline)
                        .clipShape(.buttonBorder)
                    }
                } else {
                    
                    VStack(spacing: 30) {
                        
                        Spacer()
                        
                        Section {
                            Text("Выберите количество вопросов")
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Picker("Количество вопросов",selection:$numberOfQuestion) {
                                Text("5").tag(5)
                                Text("15").tag(15)
                                Text("20").tag(20)
                            }
                            .background(.green)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
                            Text("Какая таблица умножения:")
                                .font(.title)
                                .foregroundStyle(.white)
                            
                            Picker("Table", selection: $number1) {
                                ForEach(2..<13, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        Spacer()
                        
                        Button("Начать") {
                            isOption = true
                            nextQuestion()
                            start = true
                        }
                        .frame(width: 100, height: 100)
                        .background(.purple)
                        .foregroundStyle(.white)
                        .clipShape(.circle)
                        
                        Spacer()
                        Spacer()
                    }
                }
            } else {
                VStack {
                    
                    Spacer()
                    
                    Text("Таблица умножения")
                        .padding(70)
                        .background(LinearGradient(colors: [.red,.orange], startPoint: .leading, endPoint: .bottom))
                        .font(.system(size: 27))
                    
                    Spacer()
                    
                    Button("Перейти к настройкам") {
                        start = true
                    }
                    .padding(50)
                    .background(Color.indigo)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                }
                .ignoresSafeArea()
            }
        }
        .alert("Вы набрали \(score) очков", isPresented: $isShowingAlert) {
            Button("Начать заново") {
                reset()
            }
            Button("Выбрать другую таблицу") {
                reset()
                isOption = false
            }
        }
    }
    
    func nextQuestion() {
        number2 = Int.random(in: 1...10)
    }
    
    func checkAnswer() {
        guard let userAnswer = Int(answer) else { return }
        if userAnswer == number1 * number2 {
            score += 1
        } else {
            score -= 1
        }
        round += 1
    }
    
    func final() {
        if round == numberOfQuestion {
            isShowingAlert = true
        }
        answer = ""
    }
    
    func reset() {
        round = 0
        score = 0
        answer = ""
    }
}
#Preview {
    ContentView()
}
