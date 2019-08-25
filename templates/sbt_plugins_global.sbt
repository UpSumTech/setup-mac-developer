import org.ensime.EnsimeCoursierKeys._
import org.ensime.EnsimeKeys._

ensimeRepositoryUrls in ThisBuild += "https://oss.sonatype.org/content/repositories/snapshots/"
ensimeServerVersion in ThisBuild := "2.0.0-M4" // https://github.com/ensime/ensime-server/releases
ensimeProjectServerVersion in ThisBuild := "2.0.0-M4"
ensimeJavaFlags in ThisBuild := Seq("-Xss512m", "-Xmx2g", "-XX:MaxMetaspaceSize=256m")
