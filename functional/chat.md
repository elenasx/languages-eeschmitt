# Functional Programming

Record a chat about functional programming style, and it's connection with:
1. Immutable objects.
2. Lambda functions
3. How are templates a meta-functional style?

Starting from the hello-world-scala example, add a new route that sorts a JSON list of strings using functional programming style.  Have a conversation with ChatGPT on how to modify this.

Save your conversation, your code, and screenshot of running code as this assignment.


## ChatGPT Conversation:
#### **1. Can you give me an explanation of functional programming style, along with how immutable objects and lambda functions connect to this style?**
Functional programming is a programming paradigm that treats computation as the evaluation of mathematical functions and avoids changing state and mutable data. It emphasizes the use of pure functions, first-class functions, and higher-order functions, focusing on what to solve rather than how to solve it.
#### Key Concepts of Functional Programming
1. **Pure Functions**: These functions always produce the same output for the same input and have no side effects (they don't modify any external state).
2. **First-Class Functions**: Functions are treated as first-class citizens, meaning they can be passed as arguments, returned from other functions, and assigned to variables.
3. **Higher-Order Functions**: Functions that take other functions as parameters or return them as results.
4. **Function Composition**: Combining simple functions to build more complex ones.
#### Immutable Objects
In functional programming, immutability is a core concept. Immutable objects are those whose state cannot be modified after they are created. This leads to several advantages:
- **Predictability**: Since immutable objects cannot change, you can reason about your program more easily.
- **Concurrency**: Immutability simplifies concurrent programming, as there are no worries about one part of the program changing the state while another is reading it.
- **Referential Transparency**: Expressions can be replaced with their values without changing the program's behavior, which is essential for optimizing and reasoning about code.
#### Lambda Functions
Lambda functions (or anonymous functions) are often used in functional programming for several reasons:
- **Conciseness**: They allow you to define small functions in a compact way, making the code cleaner and easier to read.
- **Higher-Order Functions**: Lambda functions are often passed as arguments to higher-order functions (like `map`, `filter`, and `reduce`), enabling functional-style operations on data collections.
#### Connection to Functional Programming
1. **Immutability**: Using immutable objects promotes a functional style by ensuring that functions don’t inadvertently alter the state of data. This leads to clearer and safer code.
2. **Lambda Functions**: They align perfectly with the principles of functional programming. They enable quick, one-off functions without the overhead of defining a named function, promoting concise code and functional transformations.
#### Conclusion
In summary, functional programming encourages writing code that is predictable, maintainable, and free of side effects, while immutable objects and lambda functions are essential tools that help achieve these goals.


#### **2. Can you explain how exactly templates are a meta-functional style when it comes to functional programming style?**
Templates in programming, particularly in languages like C++, can be considered a form of meta-programming, which allows you to write code that generates other code. This aligns well with functional programming principles in several ways:
#### Key Aspects of Templates in Meta-Functional Programming
1. **Code Reusability**: 
   - Templates enable the creation of generic, reusable code components. Instead of writing multiple versions of a function or class for different data types, you can define a template once and use it with any type. This is similar to functional programming's emphasis on reusability through pure functions.
2. **Type Safety**: 
   - Templates provide compile-time type checking, ensuring that type errors are caught early. This parallels the functional programming focus on correctness and avoiding side effects, as it reduces the likelihood of runtime errors.
3. **Higher-Order Functions**:
   - In functional programming, higher-order functions can take functions as arguments or return them. Similarly, template functions can accept other functions (or function objects) as parameters. This allows for greater flexibility and abstraction in how functions are defined and used.
4. **Generics and Abstraction**:
   - Templates allow for the creation of generic algorithms that can work with any type that satisfies certain constraints (e.g., having specific operations defined). This is akin to functional programming’s use of abstract data types and interfaces, enabling programmers to think about operations rather than the specifics of data types.
5. **Compile-Time Computation**:
   - Templates can perform computations at compile time, leading to optimizations and reducing runtime overhead. This is reminiscent of functional programming's emphasis on immutability and the use of pure functions, where many operations can be evaluated without side effects.
6. **Function Objects and Functors**:
   - Templates can define function objects (or functors), which are objects that can be called as if they were functions. This aligns with functional programming’s treatment of functions as first-class citizens and allows for powerful functional constructs within a more static type system.
#### Conclusion
In summary, templates represent a meta-functional style by promoting code reusability, type safety, abstraction, and compile-time computation, all of which resonate with the principles of functional programming. They allow developers to embrace a functional approach, even in languages that are not purely functional, enabling the use of functional programming techniques while maintaining the benefits of a statically typed system.


#### **3. How could I modify this code so that I can add a new route that sorts a JSON list of strings while keeping a functional programming style? Can you give an explanation of each line of code added?**
### Changes Made:
1. **Added JSON Support:** We included spray-json support by importing the necessary packages and defining an implicit format for our StringList case class.
2. **Case Class for Input:** 
We defined a simple StringList case class to hold the list of strings.
3. **New Route for Sorting**
We added a new route at /sort that handles POST requests. It extracts the list of strings from the JSON body, sorts them, and responds with the sorted list.

```JS
import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport._
import spray.json.DefaultJsonProtocol._
import spray.json._
import scala.io.Source

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
      path("sort") {
        post {
          entity(as[ListRequest]) { request =>
            complete(request.items.sorted)  
          }
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
}
```

#### What code would I need to finish this path so that it takes in the items to sort from a JSON file:
```JS
   path("sortjson") {
      
   }
```

To modify your code so that it reads JSON from a file and organizes it based on a new path called sortjson, you need to:
   - Add a method to read JSON from a file.
   - Parse the file content into a suitable data structure (like a ListRequest).
   - Add a new route (/sortjson) that reads JSON from a file, sorts the items, and returns the result.

Here’s how you can do it:\
Steps:
   - Add a file-reading function that reads JSON data from a file.
   - Modify the route to handle a new /sortjson endpoint, which will read the data from the file, process it, and return the sorted items.
```JS
   path("sortjson") {
      get {
         val items = readJsonFromFile("src/main/resources/test.json")
         complete(items.sorted)
      }
   }


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
```