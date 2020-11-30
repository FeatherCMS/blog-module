//
//  BlogCategoryEditForm.swift
//  BlogModule
//
//  Created by Tibor Bodecs on 2020. 03. 22..
//

import FeatherCore

final class BlogCategoryEditForm: ModelForm {

    typealias Model = BlogCategoryModel

    struct Input: Decodable {
        var modelId: String
        var title: String
        var excerpt: String
        var color: String
        var priority: String
        var image: File?
    }

    var modelId: String? = nil
    var title = StringFormField()
    var excerpt = StringFormField()
    var color = StringFormField()
    var priority = StringFormField()
    var image = FileFormField()
    var metadata: FrontendMetadata?
    var notification: String?

    var leafData: LeafData {
        .dictionary([
            "modelId": modelId,
            "title": title,
            "excerpt": excerpt,
            "color": color,
            "priority": priority,
            "image": image,
            "metadata": metadata,
            "notification": notification,
        ])
    }

    init() {
        initialize()
    }

    init(req: Request) throws {
        initialize()

        let context = try req.content.decode(Input.self)
        modelId = context.modelId.emptyToNil
        title.value = context.title
        priority.value = context.priority
        excerpt.value = context.excerpt
        color.value = context.color

        if let img = context.image, let data = img.data.getData(at: 0, length: img.data.readableBytes), !data.isEmpty {
            image.data = data
        }
    }

    func initialize() {
        priority.value = String(100)
    }

    func validate(req: Request) -> EventLoopFuture<Bool> {
        var valid = true
       
        if title.value.isEmpty {
            title.error = "Title is required"
            valid = false
        }
        if Validator.count(...250).validate(title.value).isFailure {
            title.error = "Title is too long (max 250 characters)"
            valid = false
        }
        if Int(priority.value) == nil {
            priority.error = "Invalid priority value"
            valid = false
        }
        if modelId == nil && image.data == nil {
            image.error = "Image is required"
            valid = false
        }
        return req.eventLoop.future(valid)
    }
    
    func read(from input: Model)  {
        modelId = input.id?.uuidString
        title.value = input.title
        priority.value = String(input.priority)
        excerpt.value = input.excerpt
        color.value = input.color ?? ""
        image.value = input.imageKey
    }

    func write(to output: Model) {
        output.title = title.value
        output.priority = Int(priority.value)!
        output.excerpt = excerpt.value
        output.color = color.value.emptyToNil
        if !image.value.isEmpty {
            output.imageKey = image.value
        }
        if image.delete {
            output.imageKey = ""
        }
    }
}
