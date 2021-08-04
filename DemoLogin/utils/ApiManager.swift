
import UIKit
import Foundation

enum ApiPath:String{
    case Login = "https://watch-master-staging.herokuapp.com/api/login"
    case Edit = "https://watch-master-staging.herokuapp.com/api/users/"
}

public class ApiManager{
    
    // The Singleton Facade instance
    fileprivate static var instance: ApiManager?
    // Concurrent queue for singleton instance
    fileprivate static let instanceQueue = DispatchQueue(label: "BackgroundManager", attributes: DispatchQueue.Attributes.concurrent)
    
    
    private class func getInstance(_ closure: (() -> ApiManager)) -> ApiManager {
        instanceQueue.sync(flags: .barrier, execute: {
            if(ApiManager.instance == nil) {
                ApiManager.instance = closure()
            }
        })
        return instance!
    }
    
    class func Instance() -> ApiManager {
        return getInstance { ApiManager() }
    }
    
    var key="vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD"
    private var token:String?
    var ToKen:String?{
        set{
            token = newValue
        }
        get{
            return token
        }
    }
    
    func sendApi(url:String,para:[String:String],complete: @escaping((_ data:Data?,_ error:Error?)->Void)){
        ActivityIndicatoryUtils.sharedInstance().showActivityIndicator()
        //print("input para: \(para)")
        let paraURL = QHTTPFormURLEncoded.urlEncoded(formDataSet: para)
        //print("input paraURL: \(paraURL)")

        
        guard let url = URL.init(string: url + (paraURL.isEmpty ? "" : "?\(paraURL)")) else {
            complete(nil,NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"wrong url:\(url)"]))
            ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(key, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("1", forHTTPHeaderField: "X-Parse-Revocable-Session")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = ToKen{
            request.addValue(token, forHTTPHeaderField: "X-Parse-Session-Token")
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription);
                DispatchQueue.main.async {
                    complete(nil,error)
                }
                ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
                return
            }
            guard let data = data else {
                print("Empty data");
                DispatchQueue.main.async {
                    complete(nil,NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Empty data"]))
                }
                ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
                return
                
            }

            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
            DispatchQueue.main.async {
                complete(data,nil)
            }
            ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
        }.resume()
    }
    
    func sendApiByPost(url:String,para:[String:Any],complete: @escaping((_ data:Data?,_ error:Error?)->Void)){
        ActivityIndicatoryUtils.sharedInstance().showActivityIndicator()
        guard let url = URL.init(string: url) else {
            DispatchQueue.main.async {
                complete(nil,NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"wrong url:\(url)"]))
            }
            ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue(key, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("", forHTTPHeaderField: "X-Parse-REST-API-Key")
        //request.addValue("1", forHTTPHeaderField: "X-Parse-Revocable-Session")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = ToKen{
            request.addValue(token, forHTTPHeaderField: "X-Parse-Session-Token")
        }
         let data = try! JSONSerialization.data(withJSONObject: para, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        request.httpBody = data

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription);
                DispatchQueue.main.async {
                    complete(nil,error)
                }
                ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
                return
            }
            guard let data = data else {
                print("Empty data");
                DispatchQueue.main.async {
                    complete(nil,NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:"Empty data"]))
                }
                ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
                return
                
            }

            DispatchQueue.main.async {
                complete(data,nil)
            }
            ActivityIndicatoryUtils.sharedInstance().deleteActivityIndicator()
        }.resume()
    }
    
}


extension URLRequest {
  
    private func percentEscapeString(_ string: String) -> String {
    var characterSet = CharacterSet.alphanumerics
    characterSet.insert(charactersIn: "-._* ")

    return string
      .addingPercentEncoding(withAllowedCharacters: characterSet)!
      .replacingOccurrences(of: " ", with: "+")
      .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
  
    mutating func encodeParameters(parameters: [String : String]){
        httpMethod = "POST"
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }

        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


enum QHTTPFormURLEncoded {

    static let contentType = "application/x-www-form-urlencoded"

    /// Encodings the key-values pairs in `application/x-www-form-urlencoded` format.
    ///
    /// The only specification for this encoding is the [Forms][spec] section of the
    /// *HTML 4.01 Specification*.  That leaves a lot to be desired.  For example:
    ///
    /// * The rules about what characters should be percent encoded are murky
    ///
    /// * It doesn't mention UTF-8, although many clients do use UTF-8
    ///
    /// [spec]: <http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4>
    ///
    /// - parameter formDataSet: An array of key-values pairs
    ///
    /// - returns: The returning string.

    static func urlEncoded(formDataSet: [String : String]) -> String {
        return formDataSet.map { (key, value) in
            return escape(key) + "=" + escape(value)
        }.joined(separator: "&")
    }

    /// Returns a string escaped for `application/x-www-form-urlencoded` encoding.
    ///
    /// - parameter str: The string to encode.
    ///
    /// - returns: The encoded string.

    private static func escape(_ str: String) -> String {
        // Convert LF to CR LF, then
        // Percent encoding anything that's not allow (this implies UTF-8), then
        // Convert " " to "+".
        //
        // Note: We worry about `addingPercentEncoding(withAllowedCharacters:)` returning nil
        // because that can only happen if the string is malformed (specifically, if it somehow
        // managed to be UTF-16 encoded with surrogate problems) <rdar://problem/28470337>.
        return str.replacingOccurrences(of: "\n", with: "\r\n")
            .addingPercentEncoding(withAllowedCharacters: sAllowedCharacters)!
            .replacingOccurrences(of: " ", with: "+")
    }

    /// The characters that are don't need to be percent encoded in an `application/x-www-form-urlencoded` value.

    private static let sAllowedCharacters: CharacterSet = {
        // Start with `CharacterSet.urlQueryAllowed` then add " " (it's converted to "+" later)
        // and remove "+" (it has to be percent encoded to prevent a conflict with " ").
        var allowed = CharacterSet.urlQueryAllowed
        allowed.insert(" ")
        allowed.remove("+")
        allowed.remove("/")
        allowed.remove("?")
        return allowed
    }()
}
