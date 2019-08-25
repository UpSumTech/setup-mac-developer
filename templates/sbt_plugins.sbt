addSbtPlugin("com.dwijnand" % "sbt-compat" % "1.2.6") // https://github.com/coursier/coursier/issues/778
addSbtPlugin("org.ensime" % "sbt-ensime" % "2.6.1") // https://github.com/ensime/ensime-sbt/releases
transitiveClassifiers := Seq("sources")
