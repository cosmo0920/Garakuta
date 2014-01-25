import parseForecastJson._
import forecastApiConst._

object Main {
  def main(args: Array[String]) {
    run
  }

  def run {
    import dispatch._, Defaults._
    val req = Http(url(forecastApiConst.apiUrl + forecastApiConst.cityId) OK as.String)
    val pf = new parseForecastJson
    pf.show(req)
  }
}
