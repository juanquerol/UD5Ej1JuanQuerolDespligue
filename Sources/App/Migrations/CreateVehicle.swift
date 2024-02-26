import Fluent

struct CreateVehicle: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("vehicles")
            .id()
            .field("marca", .string, .required)
            .field("modelo", .string, .required)
            .field("numeroRuedas", .int, .required)
            .field("tipoCombustible", .string, .required)
            .field("pantallaCentral", .bool, .required)
            .field("tamanoPantalla", .double, .required)
            .create()
            
    }

    func revert(on database: Database) async throws {
        try await database.schema("vehicles").delete()
    }
}