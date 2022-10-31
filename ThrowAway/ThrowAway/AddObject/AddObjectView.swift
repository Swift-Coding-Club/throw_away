//
//  AddObjectView.swift
//  ThrowAway
//
//  Created by 이건우 on 2022/11/01.
//

import SwiftUI
import PhotosUI

struct AddObjectView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var showImagePicker: Bool = false
    @State private var objectImage: UIImage? = nil
    
    @State private var objectName: String = ""
    @State private var objectDescription: String = ""
    
    private let gray112: Color = Color(red: 112/255, green: 112/255, blue: 112/255)
    private let borderColor: Color = Color(red: 231/255, green: 231/255, blue: 231/255)
    
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: (objectImage ?? UIImage(named: "objectImagePlaceholder"))!)
                .resizable()
                .frame(width: 140, height: 140)
                .clipped()
                .cornerRadius(20)
                .onTapGesture {
                    showImagePicker = true
                }
                .padding(.vertical, 15)
                .padding(.bottom, 35)
           
            VStack(alignment: .leading, spacing: 10) {
                Text("물건 내용")
                    .foregroundColor(gray112)
                    .font(.system(size: 12))
                
                TextField("이름을 입력해 주세요", text: $objectName)
                    .frame(height: 40)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 13)
                    .overlay(Rectangle().stroke(borderColor, lineWidth: 1))
                    .padding(.bottom, 10)
                
                TextField("설명을 입력해 주세요", text: $objectDescription)
                    .frame(height: 120, alignment: .top)
                    .padding(13)
                    .overlay(Rectangle().stroke(borderColor, lineWidth: 1))
                    .padding(.bottom, 42)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $showImagePicker, content: {
            PhotoPicker(isPresented: $showImagePicker) { selectedItem in
                objectImage = selectedItem
            }
        })
    }
}

struct AddObjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddObjectView()
    }
}
