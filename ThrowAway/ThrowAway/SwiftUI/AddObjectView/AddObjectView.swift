//
//  AddObjectView.swift
//  ThrowAway
//
//  Created by 이건우 on 2022/11/01.
//

import SwiftUI
import PhotosUI

struct AddObjectView: View {
    enum ViewType {
        case new
        case edit
        
        var submitText: String {
            switch self {
            case .new:
                return "만들기"
            case .edit:
                return "수정"
            }
        }
    }
    
    private let product: Product?
    private var viewType: ViewType = .new
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @State private var showImagePicker: Bool = false
    @State private var objectImage: UIImage?
    
    @State private var objectName: String = ""
    @State private var objectDescription: String = ""
    
    @State private var showDatePicker: Bool = false
    @State private var selectedDate: Date = Date()
    
    private let gray112: Color = Color(red: 112/255, green: 112/255, blue: 112/255)
    private let borderColor: Color = Color(red: 231/255, green: 231/255, blue: 231/255)
    
    init(product: Product? = nil) {
        self.product = product
        initItemValues(from: product)
    }
    
    private mutating func initItemValues(from product: Product?) {
        guard let savedProduct = product else {
            return
        }
        // TODO: 수정화면인 경우, 값을 초기화할때 coredata 에서 데이터를 불러와 값으로 저장해 둔다
        self.viewType = .edit
        self._objectName = .init(initialValue: savedProduct.title ?? "")
        self._selectedDate = .init(initialValue: savedProduct.cleaningDay ?? Date())
        self._objectDescription = .init(initialValue: savedProduct.memo ?? "")
        if let photoData = savedProduct.photo {
            self._objectImage = .init(initialValue: UIImage(data: photoData))
        }
    }
    
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
                
                Text("비움날")
                    .foregroundColor(gray112)
                    .font(.system(size: 12))
                
                HStack(spacing: 20) {
                    Image("calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                        .labelsHidden()
                        .accentColor(.green)
                        .environment(\.locale, Locale.init(identifier: "ko_KR"))
                }
                .frame(height: 40)
                .padding(.vertical, 6)
                .padding(.horizontal, 13)
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                .overlay(Rectangle().stroke(borderColor, lineWidth: 1))
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $showImagePicker, content: {
            PhotoPicker(isPresented: $showImagePicker) { selectedItem in
                objectImage = selectedItem
            }
        })
        .toolbar {
            ToolbarItem {
                Button(viewType.submitText, action: addItem)
            }
        }
    }
    
    private func addItem() {
        let newItem = Product(context: viewContext)
        newItem.memo = objectDescription
        newItem.title = objectName
        newItem.photo = objectImage?.pngData()
        newItem.cleaningDay = selectedDate
        
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddObjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddObjectView(product: nil)
    }
}
