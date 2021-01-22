resource "aws_launch_configuration" "launch_conf" {
  name = var.lc_name
  image_id = data.aws_ami.amazon2_linux.id
  instance_type = var.instance_type[var.env]
  security_groups = [var.sg]

  lifecycle {
    ignore_changes = [image_id]
  }

  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform"  >  /var/www/html/index.html
echo "<br><font color="blue">Hello World!!" >> /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
}
