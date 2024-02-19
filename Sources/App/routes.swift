import Fluent
import Vapor

func routes(_ app: Application) throws {
    let vehicleController = VehicleController()
    app.get { req in
        return req.view.render("index", ["title": "Hola Mundo"])
    }
    try app.register(collection: vehicleController)
}
