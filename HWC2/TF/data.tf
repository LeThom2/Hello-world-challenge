data "template_cloudinit_config" "user_scripts_logstash" {

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/logstash-install.sh",
      {}
    )
  }
  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/logstash-config.sh",
      {}
    )
  }

}

data "template_cloudinit_config" "user_scripts_EKF" {

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/EKF-install.sh",
      {}
    )
  }
  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/elastic-config.sh",
      {}
    )
  }
  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/kibana-config.sh",
      {
        PUBLIC_IP = "$(curl http://checkip.amazonaws.com)"
      }
    )
  }
  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/filebeat-config.sh",
      {
        PUBLIC_IP = "$(curl http://checkip.amazonaws.com)"
      }
    )
  }
  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}./scripts/python-app.sh",
      {}
    )
  }
  # part {
  #   content_type = "text/x-shellscript"
  #   content = templatefile(
  #     "${path.module}./scripts/launch-kibana.sh",
  #     {
  #       PUBLIC_IP = "$(curl http://checkip.amazonaws.com)"
  #     }
  #   )
  # }
}