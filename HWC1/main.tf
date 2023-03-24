# Copy a file with Terraform as part of Hello World Challange part 1

resource "local_file" "HWC_Copy" {
  content  = file("/Users/Thom.Benjamins/Desktop/HWC/HWC1/app.py")
  filename = "/Users/Thom.Benjamins/Desktop/HWC-Copy/app_copy.py"
}