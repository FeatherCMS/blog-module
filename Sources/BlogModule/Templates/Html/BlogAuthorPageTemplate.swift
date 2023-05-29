//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 18..
//

import Vapor
import FeatherCore
import BlogObjects
import SwiftHtml

struct BlogAuthorPageTemplate: TemplateRepresentable {
    
    var context: BlogAuthorPageContext
    
    init(_ context: BlogAuthorPageContext) {
        self.context = context
    }

    func render(_ req: Request) -> Tag {
        req.templateEngine.system.index(.init(title: context.author.name, metadata: context.author.metadata)) {
            Wrapper {
                Container {
                    Header {
                        if let imageKey = context.author.imageKey {
                            Img(src: req.fs.resolve(key: imageKey), alt: context.author.name)
                                .class("profile")
                        }
                        H1(context.author.name)
                        P(context.author.bio ?? "")
                        
                        for link in context.author.links {
                            A(link.label)
                                .href(link.url)
                                .target(.blank)
                        }
                    }
                    .class("lead")
                    
                    Section {
                        for post in context.author.posts {
                            A {
                                if let imageKey = post.imageKey {
                                    Img(src: req.fs.resolve(key: imageKey), alt: post.title)
                                }
                                Div {
                                    Span(post.metadata.date.formatted())
                                    H2(post.title)
                                    P(post.excerpt ?? "")
                                }
                                .class("content")
                            }
                            .href(post.metadata.slug)
                            .class("card")
                        }
                    }
                }
            }
            .id("blog-author")
            .class(add: "blog")
        }
        .render(req)
    }
}

