output "instances" {
    value = aws_instance.WebInstence.*.id
}