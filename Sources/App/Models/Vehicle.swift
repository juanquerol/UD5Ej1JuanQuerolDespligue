import Fluent
import Vapor

final class Vehicle: Model, Content {
    static let schema = "vehicles"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "marca")
    var marca: String

    @Field(key: "modelo")
    var modelo: String

    @Field(key: "numeroRuedas")
    var numeroRuedas: Int

    @Field(key: "tipoCombustible")
    var tipoCombustible: String

    @Field(key: "pantallaCentral")
    var pantallaCentral: Bool

    @Field(key: "tamanoPantalla")
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