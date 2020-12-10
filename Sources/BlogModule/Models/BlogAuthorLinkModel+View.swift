//
//  BlogAuthorLinkModel+View.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 11. 06..
//

import FeatherCore

extension BlogAuthorLinkModel: LeafDataRepresentable {
    
    public var leafData: LeafData {
        .dictionary([
            "id": id,
            "name": name,
            "url": url,
            "priority": priority,
        ])
    }
}
