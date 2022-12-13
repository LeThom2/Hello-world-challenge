terraform {
    provisioner "local-exec" {
        command = "chrome  https://www.google.com"
    }
}
