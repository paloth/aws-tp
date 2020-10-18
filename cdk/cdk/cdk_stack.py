from aws_cdk import core
import aws_cdk.aws_ec2
import aws_cdk.aws_elasticloadbalancingv2 as elbv2
import aws_cdk.aws_elasticloadbalancingv2_targets as targets
import aws_cdk.aws_autoscaling as asg


class CdkStack(core.Stack):

    def __init__(self, scope: core.Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)

        # The code that defines your stack goes here

        # Subnet configuration:
        public_sub = aws_cdk.aws_ec2.SubnetConfiguration(cidr_mask=24,
                                                         name='public',
                                                         subnet_type=aws_cdk.aws_ec2.SubnetType.PUBLIC)

        private_sub = aws_cdk.aws_ec2.SubnetConfiguration(cidr_mask=24,
                                                          name='private',
                                                          subnet_type=aws_cdk.aws_ec2.SubnetType.PRIVATE)

        # Create your VPC
        vpc = aws_cdk.aws_ec2.Vpc(self, 'myVPC',
                                  cidr="192.168.0.0/16",
                                  max_azs=3,
                                  subnet_configuration=[public_sub, private_sub])

        # Create security groups
        sg_alb = aws_cdk.aws_ec2.SecurityGroup(scope=self, id='sg_alb', vpc=vpc, security_group_name='alb sg')
        sg_alb.add_ingress_rule(peer=aws_cdk.aws_ec2.Peer.any_ipv4(), connection=aws_cdk.aws_ec2.Port.tcp(80))

        sg_websrv = aws_cdk.aws_ec2.SecurityGroup(scope=self, id='sg_websrv', vpc=vpc, security_group_name='websrv sg')
        sg_websrv.add_ingress_rule(peer=sg_alb, connection=aws_cdk.aws_ec2.Port.tcp(80))


        # asg
        user_data = "#!/bin/bash \n " \
                    "echo '[nginx] \n" \
                    "name=nginx repo \n" \
                    "baseurl=http://nginx.org/packages/centos/7/$basearch/ \n" \
                    "gpgcheck=0 \n" \
                    "enabled=1' | tee  /etc/yum.repos.d/nginx.repo \n" \
                    "yum -y install nginx \n" \
                    "echo \"<h1>Hello World</h1>\" > /usr/share/nginx/html/index.html \n" \
                    "systemctl enable nginx \n" \
                    "systemctl start nginx"

        as_group = asg.AutoScalingGroup(self, 'asg',
                                        instance_type=aws_cdk.aws_ec2.InstanceType('t2.micro'),
                                        vpc=vpc,
                                        security_group=sg_websrv,
                                        machine_image=aws_cdk.aws_ec2.AmazonLinuxImage(generation=aws_cdk.aws_ec2.AmazonLinuxGeneration.AMAZON_LINUX_2))
        as_group.add_user_data(user_data)

        # Create Load Balancer
        lb = elbv2.ApplicationLoadBalancer(
            self, "LB",
            vpc=vpc,
            internet_facing=True,
            security_group=sg_alb,
            vpc_subnets=aws_cdk.aws_ec2.SubnetSelection(subnet_type=aws_cdk.aws_ec2.SubnetType('PUBLIC'))
        )

        listener = lb.add_listener("Listener", port=80)
        listener.add_targets("Target", port=80,
                             targets=[as_group])

        listener.connections.allow_default_port_from_any_ipv4("Open to the world")

