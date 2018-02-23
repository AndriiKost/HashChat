//
//  MessageService.swift
//  HashChat
//
//  Created by Andrii Kost on 2/21/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    // Singleton
    static let instance = MessageService()

    var channels = [Channel]()

    func findAllChannels(completion: @escaping CompletionHandler) {
        // request for get channels
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in

            if response.result.error == nil {
                guard let data = response.data else { return }
                // can throw
                do {
                    if let json = try JSON(data: data).array {
                        // Look in each item in json array
                        for item in json {
                            // look for key and cast as string value
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            // create new channel object from the Channel struct
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            // add the object to the channels array (var channels = [Channel]())
                            self.channels.append(channel)
                        }
                    }

                } catch {
                    debugPrint(error)
                }
                print(self.channels)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
