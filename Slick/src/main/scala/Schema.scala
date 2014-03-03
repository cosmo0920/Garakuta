package net.cosmo0920.sqlite.schema

import scala.slick.driver.SQLiteDriver.simple._

case class Datum(id: Int, name: String)
object Data extends Table[Datum]("data") {
  def id = column[Int]("id", O PrimaryKey, O AutoInc)
  def name = column[String]("name")
  def * = id ~ name <> (Datum.apply _, Datum.unapply _)
  def ins = name returning id
}

trait DefaultSQLiteConnection {
  val dbname = "test.db"
  val db  = Database.forURL(s"jdbc:sqlite:$dbname", driver="org.sqlite.JDBC")
}
