resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "my_instance" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  subnet_id = "${aws_subnet.main-public-1.id}"
  security_groups = ["${aws_security_group.myinstance.id}"]

  tags {
     Name = "root_level_technologies_tasks"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.my_instance.public_ip} > instance_public_ip.txt"
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install dos2unix",
      "sudo /usr/bin/dos2unix /tmp/script.sh",
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

}

output "instance_ip_address" {
    value = "${aws_instance.my_instance.public_ip}"
}
