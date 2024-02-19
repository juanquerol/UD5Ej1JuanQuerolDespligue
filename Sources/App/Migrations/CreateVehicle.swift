import Fluent

struct CreateVehicle: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("vehicles")
            .id()
            .field("marca", .string, .required)
            .field("modelo", .string, .required)
            .field("numeroRuedas", .int, .required)
            .field("tipoCombustible", .string, .required)
            .field("pantallaCentral", .bool, .required)
            .field("tamanoPantalla", .double, .required)
            .create()
            .flatMap {
                // Insertar datos en la tabla vehicles
                let vehicle = Vehicle(marca: "Ford", modelo: "Mustang", numeroRuedas: 4, tipoCombustible: "Gasolina", pantallaCentral: true, tamanoPantalla: 10.0)
                return vehicle.save(on: database)
            }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("vehicles").delete()
    }
}