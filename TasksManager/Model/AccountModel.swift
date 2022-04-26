import Foundation
import UIKit

struct AccountInfo {
    var name:String
    var age:Int
    var userDescription:String
    var accountImage: UIImage {
    get {
    UIImage (data: imageData) ?? UIImage()
    }
}
    
    var imageData: Data = .init()

    init(name: String, age: Int, userDescription: String, accountImage: UIImage) {
        self.name = name
        self.age = age
        self.userDescription = userDescription
        self.imageData = accountImage.jpegData(compressionQuality: 1) ?? Data()
    }
}
