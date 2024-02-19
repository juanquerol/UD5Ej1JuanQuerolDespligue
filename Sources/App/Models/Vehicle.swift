import Fluent
import Vapor

final class Vehicle: modelo, Content {
    static let schema = "vehicles"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "brand")
    var brand: String

    @Field(key: "modelo")
    var modelo: String

    @Field(key: "wheel_number")
    var numeroRuedas: Int

    @Field(key: "fuel_type")
    var tipoCombustible: String

    @Field(key: "has_central_screen")
    var pantallaCentral: Bool

    @Field(key: "screen_size")
    var tamanoPantalla: Double

    init() { }

    init(id: UUID? = nil, marca: String, modelo: String, numeroRuedas: Int, tipoCombustible: String, pantallaCentral: Bool, tamanoPantalla: Double) {
        self.id = id
        self.marca = marca
        self.modelo = modelo
        self.numeroRuedas = numeroRuedas
        self.tipoCombustible = tipoCombustible
        self.pantallaCentral = pantallaCentral
        self.tamanoPantalla = tamanoPantalla
    }
}