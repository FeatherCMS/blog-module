//
//  BlogCategoryModel.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 01. 26..
//

import FeatherCore

final public class BlogCategoryModel: ViperModel {
    public typealias Module = BlogModule

    public static let name = "categories"
    
    struct FieldKeys {
        static var title: FieldKey { "title" }
        static var imageKey: FieldKey { "image_key" }
        static var excerpt: FieldKey { "excerpt" }
        static var color: FieldKey { "color" }
        static var priority: FieldKey { "priority" }
    }

    @ID() public var id: UUID?
    @Field(key: FieldKeys.title) public var title: String
    @Field(key: FieldKeys.imageKey) public var imageKey: String
    @Field(key: FieldKeys.excerpt) public var excerpt: String
    @Field(key: FieldKeys.color) public var color: String?
    @Field(key: FieldKeys.priority) public var priority: Int
    
    /// posts relation
    @Siblings(through: BlogPostCategoryModel.self, from: \.$category, to: \.$post) public var posts: [BlogPostModel]
    
    public init() { }
    
    public init( id: UUID? = nil,
                 title: String,
                 imageKey: String,
                 excerpt: String,
                 color: String? = nil,
                 priority: Int = 100)
    {
        self.id = id
        self.title = title
        self.imageKey = imageKey
        self.excerpt = excerpt
        self.color = color
        self.priority = priority
    }
}
