name := "scalate-example"

version := "0.0.1"

organization := "net.cosmo0920"

scalaVersion := "2.10.3"

resolvers += "FuseSource Public Repository" at
  "http://repo.fusesource.com/nexus/content/repositories/public"

libraryDependencies +=
  "org.fusesource.scalate" %% "scalate-core" % "1.6.1"
