//
//  BlogPostRouter.swift
//  BlogPost
//
//  Created by Tibor Bödecs on 2020. 12. 22..
//

import Foundation

public struct BlogPostGetObject: Codable {

    public var id: UUID
    public var title: String
    public var imageKey: String?
    public var excerpt: String?
    public var content: String?

    public var categories: [BlogCategoryListObject]
    public var authors: [BlogAuthorListObject]
    
    public init(id: UUID,
                title: String,
                imageKey: String?,
                excerpt: String?,
                content: String?,
                categories: [BlogCategoryListObject] = [],
                authors: [BlogAuthorListObject] = []) {
        self.id = id
        self.title = title
        self.imageKey = imageKey
        self.excerpt = excerpt
        self.content = content
        self.categories = categories
        self.authors = authors
    }

}
