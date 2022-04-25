import Foundation
import Alamofire

final class NetworkManager {
    
    static let instance = NetworkManager()
    private enum Constants {
        static let baseUrl = "https://jsonplaceholder.typicode.com"
    }
    private enum EndPoints {
        static let endUrl = "/todos"
    }
    
    private init(){}
    
    func getData (completion: @escaping(([ToDo])->Void)) {
        AF.request(Constants.baseUrl + EndPoints.endUrl).responseDecodable(of: [ToDo].self) {responseIn in
            switch responseIn.result {
            case .success(let model):
                completion(model)
            case .failure(_):
                print("ERROR")
            }
        }
    }
    
}
