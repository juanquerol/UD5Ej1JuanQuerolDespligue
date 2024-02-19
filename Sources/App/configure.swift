import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application

public func configure(_ app: Application) throws {
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor123",
        database: Environment.get("DATABASE_NAME") ?? "coches",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    app.migrations.add(CreateTodo())
     app.views.use(.leaf)
    try routes(app)
}
