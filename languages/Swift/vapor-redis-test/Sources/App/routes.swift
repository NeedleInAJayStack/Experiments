import Vapor
import Redis

func routes(_ app: Application) throws {
    app.get { req async throws in
        _ = try await req.redis.publish("Hi Redis", to: .init("channel1")).get()
        return "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.webSocket("ws") { req, websocket in
        do {
            try await req.redis.subscribe(to: [.init("channel1")]) { publisher, message in
                websocket.send(message.description)
            }.get()
        } catch {
            print(error)
        }
    }
}
