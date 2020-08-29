//
//  BlogAuthorAdminController.swift
//  FeatherCMS
//
//  Created by Tibor Bodecs on 2020. 03. 23..
//

import Vapor
import Fluent
import ViperKit
import FeatherCore

final class BlogAuthorAdminController: ViperAdminViewController {
    
    typealias Module = BlogModule
    typealias Model = BlogAuthorModel
    typealias EditForm = BlogAuthorEditForm
    
    private func path(_ model: Model) -> String {
        Model.path + model.id!.uuidString + ".jpg"
    }
    
    func beforeRender(req: Request, form: EditForm) -> EventLoopFuture<Void> {
        var future: EventLoopFuture<Void> = req.eventLoop.future()
        if let id = form.id, let uuid = UUID(uuidString: id) {
            future = findMetadata(on: req.db, uuid: uuid).map { form.contentModel = $0?.viewContext }
        }
        return future
    }
    
    func beforeCreate(req: Request, model: Model, form: EditForm) -> EventLoopFuture<Model> {
        model.id = UUID()
        var future: EventLoopFuture<Model> = req.eventLoop.future(model)
        if let data = form.image.data {
            let key = self.path(model)
            future = req.fs.upload(key: key, data: data).map { url in
                //form.image.value = url
                model.imageKey = key
                return model
            }
        }
        return future
    }
    
    func beforeUpdate(req: Request, model: Model, form: EditForm) -> EventLoopFuture<Model> {
        let key = self.path(model)
        var future: EventLoopFuture<Model> = req.eventLoop.future(model)
        if
            (form.image.delete || form.image.data != nil),
            FileManager.default.fileExists(atPath: req.fs.resolve(key: key))
        {
            future = req.fs.delete(key: key).map {
                form.image.value = ""
                return model
            }
        }
        if let data = form.image.data {
            return future.flatMap { model in
                return req.fs.upload(key: key, data: data).map { url in
                    //form.image.value = url
                    model.imageKey = key
                    return model
                }
            }
        }
        return future
    }
    
    func beforeDelete(req: Request, model: Model) -> EventLoopFuture<Model> {
        req.fs.delete(key: self.path(model)).map { model }
    }
}
