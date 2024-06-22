resource "aws_instance" "WebInstence" {
    count = length(var.ec2_names)
  ami = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index] 
  user_data = <<EOF
  #!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo yum install -y git
export META_INST_ID=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
export META_INST_TYPE=`curl -s http://169.254.169.254/latest/meta-data/instance-type`
export META_INST_AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
cd /var/www/html

echo "<!DOCTYPE html>" > index.html
echo "<html lang=\"en\">" >> index.html
echo "<head>" >> index.html
echo "    <meta charset=\"UTF-8\">" >> index.html
echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" >> index.html
echo "    <link href=\"https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap\" rel=\"stylesheet\">" >> index.html
echo "    <style>" >> index.html
echo "        body {" >> index.html
echo "            font-family: 'Roboto', sans-serif;" >> index.html
echo "            background-color: #f0f2f5;" >> index.html
echo "            color: #333;" >> index.html
echo "            margin: 0;" >> index.html
echo "            padding: 0;" >> index.html
echo "            display: flex;" >> index.html
echo "            justify-content: center;" >> index.html
echo "            align-items: center;" >> index.html
echo "            height: 100vh;" >> index.html
echo "        }" >> index.html
echo "        .container {" >> index.html
echo "            text-align: center;" >> index.html
echo "            background-color: #fff;" >> index.html
echo "            border-radius: 8px;" >> index.html
echo "            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);" >> index.html
echo "            padding: 20px;" >> index.html
echo "            width: 90%;" >> index.html
echo "            max-width: 500px;" >> index.html
echo "        }" >> index.html
echo "        .title {" >> index.html
echo "            font-size: 24px;" >> index.html
echo "            margin-bottom: 10px;" >> index.html
echo "            color: #4a90e2;" >> index.html
echo "        }" >> index.html
echo "        .info {" >> index.html
echo "            margin: 20px 0;" >> index.html
echo "        }" >> index.html
echo "        .info div {" >> index.html
echo "            margin-bottom: 10px;" >> index.html
echo "        }" >> index.html
echo "        .info-title {" >> index.html
echo "            font-weight: 700;" >> index.html
echo "        }" >> index.html
echo "        .info-text {" >> index.html
echo "            font-weight: 400;" >> index.html
echo "        }" >> index.html
echo "    </style>" >> index.html
echo "    <title>EC2 Instance Info</title>" >> index.html
echo "</head>" >> index.html
echo "<body>" >> index.html
echo "    <div class=\"container\">" >> index.html
echo "        <div class=\"title\">EC2 Instance Status</div>" >> index.html
echo "        <div class=\"info\">" >> index.html
echo "            <div>" >> index.html
echo "                <div class=\"info-title\">Instance ID:</div>" >> index.html
echo "                <div class=\"info-text\">$META_INST_ID</div>" >> index.html
echo "            </div>" >> index.html
echo "            <div>" >> index.html
echo "                <div class=\"info-title\">Instance Type:</div>" >> index.html
echo "                <div class=\"info-text\">$META_INST_TYPE</div>" >> index.html
echo "            </div>" >> index.html
echo "            <div>" >> index.html
echo "                <div class=\"info-title\">Availability Zone:</div>" >> index.html
echo "                <div class=\"info-text\">$META_INST_AZ</div>" >> index.html
echo "            </div>" >> index.html
echo "        </div>" >> index.html
echo "        <div class=\"footer\">" >> index.html
echo "            <p>Instance is running smoothly!</p>" >> index.html
echo "        </div>" >> index.html
echo "    </div>" >> index.html
echo "</body>" >> index.html
echo "</html>" >> index.html

sudo service httpd start
EOF

  tags = {
    Name = var.ec2_names[count.index]
  }
}