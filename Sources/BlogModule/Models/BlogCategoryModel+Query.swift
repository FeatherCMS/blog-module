//
//  BlogCategoryModel+Query.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 11. 06..
//

import FeatherCore

extension BlogCategoryModel {

    static public func findBy(id: UUID, on req: Request) -> EventLoopFuture<BlogCategoryModel> {
        find(id, on: req.db).unwrap(or: Abort(.notFound))
    }

    static public func findPublished(on req: Request) -> EventLoopFuture<[BlogCategoryModel]> {
        findMetadata(on: req.db)
            .filter(FrontendMetadata.self, \.$status == .published)
            .filter(FrontendMetadata.self, \.$date <= Date())
            .all()
    }
}
