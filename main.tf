# terraform {
#     backend "local" {
#     }
# }

resource "local_file" "Hello_world_challenge" {
    provisioner "file" {
        source      = "C:/Users/P432884/OneDrive - Nationwide Building Society/Desktop/Hello-world-challenge"
        destination = "Desktop"
    }
}
