import Foundation
import Alamofire

final class NetworkManager {
    
    static let instance = NetworkManager()
    private enum Constants {
        static let baseUrl = "https://jsonplaceholder.typicode.com/"
    }
    private enum EndPoints {
        static let endUrl = "/todos"
    }
    
    func getData (completion: @escaping(([ToDoModel])->Void)) {
        AF.request(Constants.baseUrl + EndPoints.endUrl).responseDecodable(of:[ToDoModel].self) {responceIn in
            switch responceIn.result {
            case .success(let model):
                completion(model)
            case .failure(_):
                print("ERROR")
            }
        }
    }
    
    private init(){}
    
}
