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

struct BlogAuthorsPageTemplate: TemplateRepresentable {
    
    var context: BlogAuthorsPageContext
    
    init(_ context: BlogAuthorsPageContext) {
        self.context = context
    }
    
    func render(_ req: Request) -> Tag {
        req.templateEngine.system.index(.init(title: req.variable("blogAuthorsPageTitle") ?? "Authors")) {
            Wrapper {
                Container {
                    LeadTemplate(.init(title: req.variable("blogAuthorsPageTitle") ?? "Authors",
                                       excerpt: req.variable("blogAuthorsPageExcerpt") ?? "")).render(req)

                    Section {
                        for author in context.authors {
                            A {
                                Div {
                                    if let imageKey = author.imageKey {
                                        Img(src: req.fs.resolve(key: imageKey), alt: author.name)
                                            .class("profile")
                                    }
                                    H2(author.name)
                                    P(author.bio ?? "")
                                }
                                .class("content")
                            }
                            .href(author.metadata.slug.safePath())
                            .class("card")
                        }
                    }
                }
            }
            .id("blog-authors")
            .class(add: "blog")
        }
        .render(req)
    }
}

