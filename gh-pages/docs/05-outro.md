# What next

## Test it

After 2 minutes, all should be set.  
Retrieve the public DNS name of your Load Balancer and test the connection with yoy web browser.

It's working ?  
**Congratulations** !!

![Congratulations](https://media.giphy.com/media/g9582DNuQppxC/giphy.gif)

Now go to the EC2 list terminate one of them and let the magic happens.

## Clean Up

Now you have to destroy what you just built !

![Destroy](https://media.giphy.com/media/2c1KjuCQTaZgc/giphy.gif)

You will have to follow this order to destroy the resources correctly.

- Auto Scaling Groups (and Launch Configuration)
- ALB
- Target group
- NAT instance (don't forget to release the Elatic IP)
- And finally VPC

## And now ?

You have built an infrastructure on AWS. That is nice but do this manually several time is quite annoying.  
I can invite you to try Infrastructure as Code tools like CloudFormation (Built-in AWS) or Terraform (It is open source). It is quite powerful.  

You will describe all of your infrastructure in a file, you will be able to deploy it, modify it, destroy it as you want and very easily. But the best part is to automate it in a CI/CD tool.

You can download a simple example done in Terraform [here]()!
