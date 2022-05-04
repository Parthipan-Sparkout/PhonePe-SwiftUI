//
//  LoginView.swift
//  PhonePe_SwiftUI
//
//  Created by Mac on 30/04/22.
//

import SwiftUI

struct LoginView: View {
    @State var mobileNumber: String = ""
    @State var password: String = ""
    @State private var isRotated = false
    @State private var isSecure = true
    @FocusState private var isFocusedMobile: Bool
    @FocusState private var isFocusedPassword: Bool
    var animation: Animation {
        Animation.easeIn
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: AppColor.themeColor, location: 0.3),
                .init(color: Color.white, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Image("appImage")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.top,30)
                    .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                    .animation(animation, value: 2.0)
                
                VStack {
                    Text("PhonePe")
                        .padding(.top)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color.white)
                    Text("Login with mobile number")
                        .font(.body)
                        .foregroundColor(Color.white)
                        .padding(.init(top: 12, leading: 0, bottom: 0, trailing: 0))
                    TextField("Mobile number", text: $mobileNumber)
                        .padding(.init(top: 15, leading: 20, bottom: 15, trailing: 20))
                        .keyboardType(.phonePad)
                        .background(Color.white)
                        .cornerRadius(12)
                        .focused($isFocusedMobile)
                        .padding(.init(top: 20, leading: 20, bottom: 5, trailing: 20))
                   
                    SecureInputView("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .focused($isFocusedPassword)
                        .padding(.init(top: 20, leading: 20, bottom: 5, trailing: 20))
                    
                    Button {
                        
                    } label: {
                        Text("Login")
                            .foregroundColor(Color.white)
                            .font(.system(size: 22, weight: .bold))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColor.themeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.init(top: 15, leading: 20, bottom: 20, trailing: 20))
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            if isFocusedMobile {
                                isFocusedMobile = false
                                isFocusedPassword = true
                            }else {
                                isFocusedPassword = false
                            }
                        }
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isRotated = true
                }
            }
        }
    }
    

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SecureInputView: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}
