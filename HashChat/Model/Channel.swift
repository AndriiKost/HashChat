//
//  Channel.swift
//  HashChat
//
//  Created by Andrii Kost on 2/21/18.
//  Copyright © 2018 Andrii Kost. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
