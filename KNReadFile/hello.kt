import kotlinx.cinterop.ByteVar
import kotlinx.cinterop.allocArray
import kotlinx.cinterop.memScoped
import kotlinx.cinterop.toKString
import platform.posix.*

fun main(args: Array<String>) {

    memScoped {
        val fp = fopen("data.txt", "r")
        if (fp == null) {
            println("File not found")
            return;
        }
        fseek(fp, 0, SEEK_END)
        val size = ftell(fp)
        fseek(fp, 0, SEEK_SET)
        val buf = allocArray<ByteVar>(size)
        fread(buf, 1, size, fp)
        fclose(fp)

        val str = buf.toKString()
        println("File content is " + str + ",and the content length is " + str.length)
    }
}
