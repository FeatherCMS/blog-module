//
//  BlogPostModel.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2019. 12. 17..
//

import FeatherCore

final public class BlogPostModel: ViperModel {
    public typealias Module = BlogModule
    
    public static let name = "posts"

    struct FieldKeys {
        static var title: FieldKey { "title" }
        static var imageKey: FieldKey { "image_key" }
        static var excerpt: FieldKey { "excerpt" }
        static var content: FieldKey { "content" }
    }
    
    // MARK: - fields

    @ID() public var id: UUID?
    @Field(key: FieldKeys.title) public var title: String
    @Field(key: FieldKeys.imageKey) public var imageKey: String
    @Field(key: FieldKeys.excerpt) public var excerpt: String
    @Field(key: FieldKeys.content) public var content: String
    
    @Siblings(through: BlogPostCategoryModel.self, from: \.$post, to: \.$category) public var categories: [BlogCategoryModel]
    @Siblings(through: BlogPostAuthorModel.self, from: \.$post, to: \.$author) public var authors: [BlogAuthorModel]

    public init() { }
    
   public init(id: UUID? = nil,
         title: String,
         imageKey: String,
         excerpt: String,
         content: String)
    {
        self.id = id
        self.title = title
        self.imageKey = imageKey
        self.excerpt = excerpt
        self.content = content
    }
}
