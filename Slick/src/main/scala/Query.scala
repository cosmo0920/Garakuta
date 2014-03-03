package net.cosmo0920.sqlite.query

import net.cosmo0920.sqlite.schema._
import scala.slick.driver.SQLiteDriver.simple._
import scala.language.postfixOps

object DBQuery extends DefaultSQLiteConnection  {
  import Database.threadLocalSession
  def setup {
    db withSession {
      Data.ins.insert("test")
      Data.ins.insert("test2")
      Data.ins.insert("hoge")
      Data.ins.insert("fuga")
      Data.ins.insert("piyo")
    }
  }

  def display {
    db withSession {
      // print
      val q = for (c <- Data) yield ConstColumn("") ++
        c.id.asColumnOf[String] ++
        " " ++
        c.name
      q foreach println
    }
  }

  def selectQuery {
    db withSession {
      val qlist = Query(Data).list
      for (c <- qlist)
        println(c)
    }
  }

  def selectWhereQuery {
    db withSession {
      val wlist = Query(Data)
        .filter(_.id <= 3)
        .map(row => (row.id, row.name)) //.firstOption if it wants to get first value only
      for (c <- wlist)
        println(c)
    }
  }

  def createTable {
    db withSession {
      // create data table
      try {
        Data.ddl.drop
      } catch {
        case ex: java.sql.SQLException => println("data table does not exist.")
      } finally {
        Data.ddl.create
        println("create data table")
      }
    }
  }

  def count:Int = {
    db withSession {
      Query(Data).map(_.id.count).first
    }
  }
}
