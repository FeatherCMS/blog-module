//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 24..
//

import SwiftHtml

struct BlogHomePageTemplate: TemplateRepresentable {
    
    var context: BlogHomePageContext
    
    init(_ context: BlogHomePageContext) {
        self.context = context
    }
    
    @TagBuilder
    func render(_ req: Request) -> Tag {
        WebIndexTemplate(.init(title: req.variable("blogHomePageTitle") ?? "Blog")) {
            Div {
                Header {
                    H1(req.variable("blogHomePageTitle") ?? "Blog")
                    P(req.variable("blogHomePageExcerpt") ?? "Latest posts")
                }
                .class("lead")
                
                Section {
                    for post in context.posts {
                        A {
                            Div {
                                if let imageKey = post.imageKey {
                                    Img(src: req.fs.resolve(key: imageKey), alt: post.title)
                                }
                                H2(post.title)
                                P(post.excerpt ?? "")
                            }
                            .class("content")
                        }
                        .href(post.metadata.slug.safePath())
                        .class("card")
                    }
                }
                .class("grid-6")
            }
            .id("blog-home")
        }
        .render(req)
    }
}

