<h1 style="font-weight: bold;" align="center">Network</h1>

The first thing you need to create to be able to deploy your infrastructure is the network.  
On this chapter we will see how to deploy a VPC, Subnets and how to route everything.

<h2 style="font-weight: bold;">VPC</h2>

Navigate through the web UI and go to the VPC.  
Create a VPC, name it as you wish.  
The CIDR block should be a non-routable one (e.g. 192.168.0.0/16)  
Let the default configuration for the moment.

<h2 style="font-weight: bold;" align="right">Subnets</h2>

Now you have created your vpc, you will have to split it up in subnets.  
Create two subnet per availability zone. In each AZ, one subnet will be **public** and one will be **private**.  

For your Subnets, you can chose a CIDR like /24. Keep it simple!

<h2 style="font-weight: bold;">Gateways</h2>

Create an internet Gateway.  
Name it as you want and attach it to your VPC.  
Create a NAT Gateway, Select one of the **public** subnet you have created previously. Select an Elastic IP. If your dropdown list is empty, you will be able to create an Elastic IP and attach it to your NAT Gateway.

<h2 style="font-weight: bold;" align="right">Route Tables</h2>

Create two route tables, name them public and private (for example)

On the public one:
Add a default route to the Internet Gateway.  
Edit the subnet association and add the public subnets.

On the private one:
Add a default route to the NAT instance.  
Edit the subnet association and add the private subnets.

```text
Default route = 0.0.0.0/0
```
