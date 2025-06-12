import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.post("api", "tracks") { req -> EventLoopFuture<Tracks> in
        let track = try req.content.decode(Tracks.self)
        return track.save(on: req.db).map { track }
    }
//    app.get("get tracks") { req-> EventLoopFuture<[Tracks]> in
//        "Hello, world!"
//    }

    app.get("api","tracks"){ req -> EventLoopFuture<[Tracks]>in
        Tracks.query(on: req.db).all()
    }
    app.get("api","tracks","idtrack",":trackID"){req -> EventLoopFuture<Tracks> in
        Tracks.find(req.parameters.get("trackID"), on: req.db).unwrap(or: Abort(.notFound))
    }
    app.put("api","tracks","puting",":trackID"){req ->EventLoopFuture<Tracks> in
        
        let udTrack = try req.content.decode(Tracks.self)
        
        
        
        return Tracks.find(req.parameters.get("trackID"),
                           on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { track in
            
            track.title = udTrack.title
            track.artist = udTrack.artist
            track.genre = udTrack.genre
            track.fileURL = udTrack.fileURL
            
            return track.update(on: req.db).map { track }
        }
    }
    app.delete("track","delete",":trackID"){req -> EventLoopFuture<HTTPStatus> in
        Tracks.find(req.parameters.get("trackID") , on: req.db )
            .unwrap(or: Abort(.notFound))
            .flatMap{track in
                track.delete(on : req.db)
                    .transform(to: .noContent)
            }
    }
}

