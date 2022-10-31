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
    
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: (objectImage ?? UIImage(named: "objectImagePlaceholder"))!)
                .resizable()
                .frame(width: 140, height: 140)
                .cornerRadius(20)
                .onTapGesture {
                    showImagePicker = true
                }
                .padding(.vertical, 15)
            
            Spacer()
        }
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
