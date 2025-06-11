//
//  Tracks.swift
//  PlayerBackApp
//
//  Created by Bogdan Sakhno on 10.06.25.
//


import Vapor
import Fluent

final class Tracks:Model, @unchecked Sendable, Content{
    static let schema = "tracks"

    @ID
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "artist")
    var artist: String

    @Field(key: "genre")
    var genre: String

    @Field(key: "file_url")
    var fileURL: String

    init() { }

    init(id: UUID? = nil, title: String, artist: String, genre: String, fileURL: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.genre = genre
        self.fileURL = fileURL
    }
}
