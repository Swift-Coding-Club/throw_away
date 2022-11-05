//
//  PhotoPicker.swift
//  ThrowAway
//
//  Created by 이건우 on 2022/11/01.
//

import SwiftUI
import UIKit
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var didFinishPicking: (_ didSelectItems: UIImage) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .current
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: PHPickerViewControllerDelegate {
    private let parent: PhotoPicker
    
    init(_ parent: PhotoPicker) {
        self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard !results.isEmpty else { return }
        
        let itemProvider = results[0].itemProvider
        getPhoto(from: itemProvider)
        
        parent.isPresented = false
    }
    
    private func getPhoto(from itemProvider: NSItemProvider) {
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let image = object as? UIImage {
                    DispatchQueue.main.async { [weak self] in
                        self?.parent.didFinishPicking(image)
                    }
                }
            }
        }
    }
}
