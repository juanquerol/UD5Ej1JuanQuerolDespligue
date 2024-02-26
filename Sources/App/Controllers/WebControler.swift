import Fluent
import Vapor

struct WebController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
        routes.get(":id", use: detalles)
    }

    func index(req: Request) async throws -> View {
        let vehicles = try await Vehicle.query(on: req.db).all()
        return try await req.view.render("index", ["vehicles": vehicles])
    }

    func detalles(req: Request) async throws -> View {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let vehicle = try await Vehicle.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("detalles", ["vehicle": vehicle])
    }
}