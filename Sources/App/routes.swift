import Fluent
import Vapor

func routes(_ app: Application) throws {
    let vehicleController = VehicleController()
    let WebController = WebController()
    app.get { req in
        return req.view.render("index", ["title": "Hola Mundo"])
    }
    try app.register(collection: vehicleController)
    try app.register(collection: WebController)
}
