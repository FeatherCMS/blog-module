//
//  BlogPostRouter.swift
//  BlogPost
//
//  Created by Tibor Bödecs on 2020. 12. 22..
//

import Foundation

public struct BlogPostListObject: Codable {

    public var id: UUID
    public var title: String?
    public var imageKey: String?
    public var excerpt: String?
    public var updated_at: Date?
    public var created_at: Date?
    public var deleted_at: Date?

    public init(id: UUID,
                title: String?,
                imageKey: String?,
                excerpt: String?,
                updated_at: Date?,
                created_at: Date?,
                deleted_at: Date?
                ) {
        self.id = id
        self.deleted_at = deleted_at
        self.updated_at = updated_at
        self.created_at = created_at
        guard deleted_at == nil else {
            return
        }
        self.title = title
        self.imageKey = imageKey
        self.excerpt = excerpt
    }

}
