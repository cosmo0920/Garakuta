import net.cosmo0920.sqlite.schema._

object Main extends DefaultSQLiteConnection {
  def main(args: Array[String]) {
    run
  }

  def run {
    import net.cosmo0920.sqlite.query.DBQuery._
    // CREATE
    createTable
    //// insert item(s)
    setup
    /// print
    println("--print--")
    display
    // SELECT
    println("--select--")
    selectQuery
    // SELECT ~ WHERE ~
    println("--select ~ where--")
    selectWhereQuery
    val cnt = count
    println(cnt)
  }
}
