//
//  BlogAuthorModel.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 01. 26..
//

import FeatherCore

final public class BlogAuthorModel: ViperModel {

    public typealias Module = BlogModule
    
    public static let name = "authors"
    
    public struct FieldKeys {
            static public var name: FieldKey { "name" }
            static public var imageKey: FieldKey { "imageKey" }
            static public var bio: FieldKey { "bio" }
    }

    // MARK: - fields

    @ID() public var id: UUID?
    @Field(key: FieldKeys.name) public var name: String
    @Field(key: FieldKeys.imageKey) public var imageKey: String
    @Field(key: FieldKeys.bio) public var bio: String
    @Children(for: \.$author) public var links: [BlogAuthorLinkModel]
    @Children(for: \.$author) public var posts: [BlogPostModel]
    
    public init() { }
    
    public init( id: UUID? = nil,
                 name: String,
                 imageKey: String,
                 bio: String)
    {
        self.id = id
        self.name = name
        self.imageKey = imageKey
        self.bio = bio
    }
}
