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

    func index(req: Request) throws -> EventLoopFuture<[Vehicle]> {
        return Vehicle.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Vehicle> {
        let vehicle = try req.content.decode(Vehicle.self)
        return vehicle.save(on: req.db).map { vehicle }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Vehicle.find(req.parameters.get("vehicleID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }

    func get(req: Request) throws -> EventLoopFuture<Vehicle> {
        return Vehicle.find(req.parameters.get("vehicleID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func update(req: Request) throws -> EventLoopFuture<Vehicle> {
        let input = try req.content.decode(Vehicle.self)
        return Vehicle.find(req.parameters.get("vehicleID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { vehicle in
                vehicle.marca= input.marca
                vehicle.modelo = input.modelo
                vehicle.numeroRuedas = input.numeroRuedas
                vehicle.tipoCombustible = input.tipoCombustible
                vehicle.pantallaCentral = input.pantallaCentral
                vehicle.tamanoPantalla = input.tamanoPantalla
                return vehicle.save(on: req.db).map { vehicle }
            }
    }
}