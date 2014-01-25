import dispatch._, Defaults._
import org.json4s._
import org.json4s.native.JsonMethods._
import parseForecastJson._
import forecastApiConst._

object Main {
  def main(args: Array[String]) {
    run
  }

  def run {
    val req = Http(url(forecastApiConst.apiUrl + forecastApiConst.cityId) OK as.String)
    val pf = new parseForecastJson
    pf.show(req)
  }
}
