import top.yunp.IsAdmin

@IsAdmin
fun hello(): Unit {
    println("Hello kotlin")
}

fun main(args: Array<String>) {

    val user = "admin"
    var hasRequireAdminAnn = false
    for (ann in ::hello.annotations) {
        if (ann is IsAdmin) {
            hasRequireAdminAnn = true
            break
        }
    }

    if (hasRequireAdminAnn) {
        if (user == "admin") {
            hello()
        } else {
            System.err.println("user is not admin")
        }
    } else {
        hello()
    }
}