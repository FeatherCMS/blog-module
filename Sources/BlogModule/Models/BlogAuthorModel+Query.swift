//
//  BlogAuthorModel+Query.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 11. 06..
//

import FeatherCore

extension BlogAuthorModel {

    static public func findBy(id: UUID, on req: Request) -> EventLoopFuture<BlogAuthorModel> {
        query(on: req.db)
            .filter(\.$id == id)
            .with(\.$links)
            .first()
            .unwrap(or: Abort(.notFound))
    }

    static public func findPublished(on req: Request) -> EventLoopFuture<[BlogAuthorModel]> {
        findMetadata(on: req.db)
            .filter(FrontendMetadata.self, \.$status == .published)
            .filter(FrontendMetadata.self, \.$date <= Date())
            .all()
    }
}
