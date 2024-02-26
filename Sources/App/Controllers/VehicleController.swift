import Fluent
import Vapor

import Fluent
import Vapor

struct VehicleController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let vehicles = routes.grouped("vehicles")
        vehicles.get(use: index)
        vehicles.post(use: create)
        vehicles.group(":vehicleID") { vehicle in
            vehicle.delete(use: delete)
            vehicle.get(use: get)
            vehicle.put(use: update)
        }
    }

    func index(req: Request) async throws -> View {
        let vehicles = try await Vehicle.query(on: req.db).all()
        return try await req.view.render("index", ["vehicles": vehicles])
    }
    

    func create(req: Request) async throws -> Vehicle {
        let vehicle = try req.content.decode(Vehicle.self)
        try await vehicle.save(on: req.db)
        return vehicle
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let vehicle = try await Vehicle.find(req.parameters.get("vehicleID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await vehicle.delete(on: req.db)
        return .ok
    }

    func get(req: Request) async throws -> View {
        guard let id = req.parameters.get("vehicleID", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let vehicle = try await Vehicle.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("detalles", ["vehicle": vehicle])
    }

    func update(req: Request) async throws -> Vehicle {
        guard let vehicle = try await Vehicle.find(req.parameters.get("vehicleID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let input = try req.content.decode(Vehicle.self)
        vehicle.marca = input.marca
        vehicle.modelo = input.modelo
        vehicle.numeroRuedas = input.numeroRuedas
        vehicle.tipoCombustible = input.tipoCombustible
        vehicle.pantallaCentral = input.pantallaCentral
        vehicle.tamanoPantalla = input.tamanoPantalla
        try await vehicle.save(on: req.db)
        return vehicle
    }
}