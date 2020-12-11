//
//  BlogAuthorModel+View.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 11. 06..
//

import FeatherCore

extension BlogAuthorModel: LeafDataRepresentable {

    var leafData: LeafData {
        .dictionary([
            "id": id,
            "name": name,
            "imageKey": imageKey,
            "bio": bio,
            "links": $links.value != nil ? links.sorted { $0.priority > $1.priority } : [],
            "posts": $posts.value != nil ? posts : [],
        ])
    }
}

extension BlogAuthorModel: FormFieldOptionRepresentable {

    var formFieldOption: FormFieldOption {
        .init(key: id!.uuidString, label: name)
    }
}
