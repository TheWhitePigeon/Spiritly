//
//  SignInView.swift
//  RiveAnimated
//
//  Created by Zhanet Nikolovska on 4.11.25.
//

import SwiftUI
import RiveRuntime


struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    @Binding var showModal: Bool
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    
    func logIn(){
        if email != ""{
            //try? check.triggerInput("Check", stateMachine: "State Machine 1")
            // check.triggerInput("Check", stateMachineName: "State Machine 1")
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                  check.triggerInput("Check")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
                  confetti.triggerInput("Trigger Explosion")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                withAnimation{
                    showModal = false
                }
            }
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                  check.triggerInput("Error")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                isLoading = false
            }
        }
     


    }
    
    var body: some View {
        ZStack {
            background
            
            Rectangle()
            .fill(.ultraThinMaterial)
            .frame(width:360, height: 650)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
            .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke (.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
                
            )
          
            
            VStack(spacing: 24){
                
                
                Text("Sign In")
                    .font(.custom("Poppins Bold", size: 34, relativeTo: .largeTitle))
                Text("Access to 240+ houyrs of content. Learn design and code by building real apps with React and Swift.")
                    .customFont(.headline)
                
                VStack(alignment: .leading){
                    Text("Email")
                        .customFont(.subheadline)
                        .foregroundStyle(.secondary)
                    TextField("", text: $email)
                        .customTextField()
                }
                
                VStack(alignment: .leading){
                    Text("Password")
                        .customFont(.subheadline)
                        .foregroundStyle(.secondary)
                    SecureField("", text: $password)
                        .customTextField(image: Image("Icon Lock"))
                }
                
                Button{
                    
                    logIn()
                }
                
                label: {
                    
                 
                    Label("Sign In", systemImage: "arrow.right")
                        .customFont(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "F77D8E"))
                        .foregroundStyle(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: .topLeft)
                        .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
                }
                
                HStack{
                    Rectangle().frame(height: 1).opacity(0.1)
                    Text("OR").customFont(.subheadline).foregroundStyle(.black.opacity(0.3))
                    Rectangle().frame(height: 1).opacity(0.1)
                }
                
                
                Text("Sign in with Email, Apple or Google")
                    .foregroundStyle(.secondary)
                HStack{
                    Image("Logo Email")
                    Spacer()
                    Image("Logo Apple")
                    Spacer()
                    Image("Logo Google")
                }
                
            }
            
            .padding(50)
            .overlay(
                ZStack{
                    if isLoading{
                        check.view()
                            .frame(width: 100, height: 100)
                            .allowsHitTesting(false)
                        
                      }
                    confetti.view()
                        .scaleEffect(3)
                        .allowsHitTesting(false)
                }
             
            )
            
            
        }
     
        
        
    }
    var background: some View{
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 100)
            )
    }
}

#Preview {
    SignInView(showModal: .constant(true))
}
