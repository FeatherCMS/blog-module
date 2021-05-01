//
//  BlogPostModel+Api.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 12. 11..
//

import FeatherCore
import BlogModuleApi

extension BlogPostListObject: Content {}
extension BlogPostGetObject: Content {}
extension BlogPostCreateObject: Content {}
extension BlogPostUpdateObject: Content {}
extension BlogPostPatchObject: Content {}

struct BlogPostApi: FeatherApiRepresentable {
    typealias Model = BlogPostModel
    
    typealias ListObject = BlogPostListObject
    typealias GetObject = BlogPostGetObject
    typealias CreateObject = BlogPostCreateObject
    typealias UpdateObject = BlogPostUpdateObject
    typealias PatchObject = BlogPostPatchObject
    
    func mapList(model: Model) -> ListObject {
        .init(id: model.id!, title: model.title, imageKey: model.imageKey, excerpt: model.excerpt, updated_at: model.updatedAt, created_at: model.createdAt, deleted_at: model.deletedAt)
    }
    
    func mapGet(model: Model) -> GetObject {
        var apiCategories = [BlogCategoryApi.ListObject]()
             for catmodel in model.categories {
                 apiCategories.append(BlogCategoryApi.ListObject.init(id: catmodel.id!,
                                                                      title: catmodel.title,
                                                                      imageKey: catmodel.imageKey,
                                                                      color: catmodel.color,
                                                                      priority: catmodel.priority,
                                                                      updated_at: catmodel.updatedAt,
                                                                      created_at: catmodel.createdAt,
                                                                      deleted_at: catmodel.deletedAt)
                 )
             }
             var apiAuthors = [BlogAuthorApi.ListObject]()
             for authmodel in model.categories {
                 apiAuthors.append(BlogAuthorApi.ListObject.init(id: authmodel.id!,
                                                                 name: authmodel.title,
                                                                 imageKey: authmodel.imageKey,
                                                                 updated_at: authmodel.updatedAt,
                                                                 created_at: authmodel.createdAt,
                                                                 deleted_at: authmodel.deletedAt)
                 )
             }
        return GetObject.init(id: model.id!, title: model.title, imageKey: model.imageKey, excerpt: model.excerpt, content: model.content, updated_at: model.updatedAt, created_at: model.createdAt, categories: apiCategories, authors: apiAuthors)
    }
    
    func mapCreate(_ req: Request, model: Model, input: CreateObject) -> EventLoopFuture<Void> {
        return req.eventLoop.future()
    }
        
    func mapUpdate(_ req: Request, model: Model, input: UpdateObject) -> EventLoopFuture<Void> {
        return req.eventLoop.future()
    }

    func mapPatch(_ req: Request, model: Model, input: PatchObject) -> EventLoopFuture<Void> {
        return req.eventLoop.future()
    }
    
    func validateCreate(_ req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }
    
    func validateUpdate(_ req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }
    
    func validatePatch(_ req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }
}
