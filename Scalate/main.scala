package net.cosmo0920
import java.io.File
import org.fusesource.scalate._
import org.fusesource.scalate.support._
object Program {
  def main(args: Array[String]) {

    val engine = new TemplateEngine
    try {
      engine.workingDirectory = new File("./tmp")
      val bindings = Map(
        "name" -> "Scalate",
        "languages" -> List("Java", "Scala", "Clojure", "Groovy", "JRuby", "Ceylon")
      )
      val output = engine.layout("template/template.scaml", bindings)

      println(output)
    } finally {
      //1.6.1では不要？
      //engine.compiler.asInstanceOf[ScalaCompiler].compiler.askShutdown()
    }
  }
}
