import Vapor
import Redis

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.redis.configuration = try RedisConfiguration(
        hostname: "localhost",
        port: 6379
    )
    
    // register routes
    try routes(app)
}
