// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import SearchLocationController from "./search_location_controller"
application.register("search-location", SearchLocationController)
import SearchHikesController from "./search_hikes_controller"
application.register("search-hikes", SearchHikesController)
