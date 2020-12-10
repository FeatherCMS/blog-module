//
//  BlogPostModel+Metadata.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 07. 22..
//

import FeatherCore

extension BlogPostModel: FrontendMetadataChangeDelegate {
    
    public var slug: String { title.slugify() }
    
    public func willUpdate(_ metadata: FrontendMetadata) {
        metadata.slug = slug
        metadata.title = title
        metadata.excerpt = excerpt
        metadata.imageKey = imageKey
    }
}

