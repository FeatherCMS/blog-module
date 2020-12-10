//
//  BlogAuthorLinkModel.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 01. 26..
//

import FeatherCore

final public class BlogAuthorLinkModel: ViperModel {
    public typealias Module = BlogModule

    static public let name = "links"
    
    struct FieldKeys {
        static var label: FieldKey { "label" }
        static var url: FieldKey { "url" }
        static var priority: FieldKey { "priority" }
        static var authorId: FieldKey { "author_id" }
    }
    
    // MARK: - fields

    @ID() public var id: UUID?
    @Field(key: FieldKeys.label) public var label: String
    @Field(key: FieldKeys.url) public var url: String
    @Field(key: FieldKeys.priority) public var priority: Int
    @Parent(key: FieldKeys.authorId) public var author: BlogAuthorModel
    
    public init() { }
    
    public init(id: UUID? = nil,
         label: String,
         url: String,
         priority: Int = 10,
         authorId: UUID)
    {
        self.id = id
        self.label = label
        self.url = url
        self.priority = priority
        self.$author.id = authorId
    }
}
