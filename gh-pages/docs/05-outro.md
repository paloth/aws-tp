<h1 style="font-weight: bold;" align="center">Finally</h1>

<h2 style="font-weight: bold;">Test it</h2>

After 2 minutes, all should be set.  
Retrieve the public DNS name of your Load Balancer and test the connection with yoy web browser.

It's working ?  
**Congratulations** !!

<div align="center" ><img alt="Congratulations" src="https://media.giphy.com/media/g9582DNuQppxC/giphy.gif" /></div>

Now go to the EC2 list terminate one of them and let the magic happens.

<h2 style="font-weight: bold;" align="right">Clean Up</h2>

Now you have to destroy what you just built !

<div align="center" ><img alt="Destroy" src="https://media.giphy.com/media/2c1KjuCQTaZgc/giphy.gif" /></div>

You will have to follow this order to destroy the resources correctly.

- Auto Scaling Groups (and Launch Configuration)
- ALB
- Target group
- NAT instance (don't forget to release the Elatic IP)
- And finally VPC

<h2 style="font-weight: bold;">And now ?</h2>

You have built an infrastructure on AWS. That is nice but do this manually several time is quite annoying.  
I can invite you to try Infrastructure as Code tools like CloudFormation (Built-in AWS) or Terraform (It is open source). It is quite powerful.  

You will describe all of your infrastructure in a file, you will be able to deploy it, modify it, destroy it as you want and very easily. But the best part is to automate it in a CI/CD tool.

You can download a simple example done in Terraform [here]()!
