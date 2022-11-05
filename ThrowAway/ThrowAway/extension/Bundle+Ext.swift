//
//  Bundle+Ext.swift
//  ThrowAway
//
//  Created by Sally on 2022/11/04.
//

import Foundation


extension Bundle {
    
    private static var bundle: Bundle?

    
    static func normalModule(_ bundleName: String) ->  Bundle? {

        var candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            
            // Bundle should be present here when the package is linked into a framework.
            //            Bundle(for: PhotoPreviewSheet.self).resourceURL,
            
            // For command-line tools.
            Bundle.main.bundleURL
        ]
        
#if SWIFT_PACKAGE
        // For SWIFT_PACKAGE.
        candidates.append(Bundle.module.bundleURL)
#endif
        
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        return nil
    }
    
    class func getFilePathsFromBundle(bundleName: String, folderName: String, fileType: String) -> [String] {
        
        guard let path = Bundle.normalModule(bundleName)?.path(forResource: folderName, ofType: nil) else {
            return []
        }
        self.bundle = Bundle(path: path)
        guard let paths = bundle?.paths(forResourcesOfType: fileType, inDirectory: nil) else { return [] }
        
        return paths
    }
    
}


