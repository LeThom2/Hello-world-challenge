resource elasticsearch_index_lifecycle_policy "1d" {
  name = "1d"
  policy = <<EOF
{
  "policy": {
      "delete": {
        "min_age": "1d",
        "actions": {
          "delete": {}
        }
      }
    }
  
}
EOF
}