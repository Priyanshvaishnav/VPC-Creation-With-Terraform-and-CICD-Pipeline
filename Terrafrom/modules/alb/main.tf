#ALB

resource "aws_lb" "alb" {
    name              = "ApplicationLoadBalancer"
    internal         = false
    load_balancer_type = "application"
    security_groups = [var.sg_id] 
    subnets = var.subnets

}


#Creating Listener

resource "aws_lb_listener" "Listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}



#target group creation
resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}




#TArget Grouo attachment


resource "aws_lb_target_group_attachment" "target_group_attachment" {
    count = length(var.instance)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance[count.index]
  port             = 80
}
