//
//  SocketService.swift
//  HashChat
//
//  Created by Andrii Kost on 2/23/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    // because it's NSObject, we need to initialize our singleton
    override init() {
        super.init()
    }
    
    // Creating a socket and pointing to our API url
    let manager = SocketManager(socketURL:URL(string: BASE_URL)!, config: [.log(true),.compress])
    
    // establish the connection between our app and server
    func establishConnection() {
        manager.defaultSocket.connect()
    }
    
    // disconnect from the server
    func closeConnection() {
        manager.defaultSocket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        // emit from the app to API
        manager.defaultSocket.emit(SOCKET_EVT_NEW_CHANNEL, name, description)
        
        completion(true)
        
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        // listening for the event (ack-acknowledgement)
        manager.defaultSocket.on(SOCKET_EVT_CHANNEL_CREATED) { (dataArray, ack) in
            
            // receive a name of channel
            guard let name = dataArray[0] as? String else {return}
            // receive a description of channel
            guard let description = dataArray[1] as? String else {return}
            // receive an id of channel
            guard let id = dataArray[2] as? String else {return}
            
            // create and Object of type Channel with received data
            let newChannel = Channel(channelTitle: name, channelDescription: description, id: id)
            
            // add the object to our array of objects
            MessageService.instance.channels.append(newChannel)
            
            completion(true)
            
        }
    }
    
    
    
}
