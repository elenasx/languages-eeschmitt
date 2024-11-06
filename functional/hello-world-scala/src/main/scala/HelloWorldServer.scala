// src/main/scala/HelloWorldServer.scala

import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport._
import spray.json.DefaultJsonProtocol._
import spray.json._
import scala.io.Source
// adds necessary imports for json
import scala.io.StdIn

object HelloWorldServer {

  implicit val stringListFormat = jsonFormat1(ListRequest)

  case class ListRequest(items: List[String])

  def main(args: Array[String]): Unit = {
    // Create an ActorSystem
    implicit val system = ActorSystem(Behaviors.empty, "helloWorldSystem")
    implicit val executionContext = system.executionContext

    // Define the route
    val route =
      path("greet" / Segment) { person =>
        get {
          complete(s"Hello, $person!")
        }
      } ~
      path("sort") { // sorts the items given in the request
        post {
          entity(as[ListRequest]) { request =>
            complete(request.items.sorted)  
          }
        }
      } ~
      path("sortjson") { //sorts the items from the test.json file
        get {
          val items = readJsonFromFile("src/main/resources/test.json")
          complete(items.sorted)
        }
      }

    // Start the server
    val bindingFuture = Http().newServerAt("localhost", 8080).bind(route)

    println("Server online at http://localhost:8080/\nPress RETURN to stop...")
    StdIn.readLine() // Keep the server running until user presses return
    bindingFuture
      .flatMap(_.unbind()) // Unbind from the port
      .onComplete(_ => system.terminate()) // Terminate the system when done
  }

  // Function to take in a path to a json file and read through the items
  def readJsonFromFile(filePath: String): List[String] = {
    val source = Source.fromFile(filePath)
    try {
      val jsonString = source.getLines().mkString
      val jsonAst = jsonString.parseJson
      jsonAst.convertTo[ListRequest].items
    } finally {
      source.close()
    }
  }
}