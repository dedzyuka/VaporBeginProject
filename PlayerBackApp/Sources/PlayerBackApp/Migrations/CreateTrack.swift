//
//  CreateTrack.swift
//  PlayerBackApp
//
//  Created by Bogdan Sakhno on 10.06.25.
//


import Fluent

struct CreateTrack: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("tracks")
            .id()
            .field("title", .string, .required)
            .field("artist", .string, .required)
            .field("genre", .string, .required)
            .field("file_url", .string)
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("tracks").delete()
    }
}
