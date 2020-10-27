<h1 style="font-weight: bold;" align="center">AutoScaling Group</h1>

<h2 style="font-weight: bold;">Create a launch configuration</h2>

- **Step 1**
  - Select your favorite AMI (Amazon Linux 2 works fine)
- **Step 2**
  - Select t2.micro
- **Step 3**
  - **Name**: *WebSrvLC*
  - **Purchasing option**: leave unchecked (we don't need Spot Instance for this hands-on)
  - **IAM Role**: None
  - **Monitoring**: Leave unchecked (No need detailed information)
  - **Advanced Details**:
    - **Kernel ID**: Use default
    - **RAM Dsik ID**: Use default
    - **Ip Address type**: Do not assign a public IP address to any instances.
    - **User Data**: Copy paste the following script

```shell
#!/bin/bash

echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1' | tee  /etc/yum.repos.d/nginx.repo
yum -y install nginx
echo "<h1>Hello World</h1>" > /usr/share/nginx/html/index.html
systemctl enable nginx
systemctl start nginx
```

- **Step 4**
  - **Storage**: Leave by default (Just check if Delete on Termination is checked)
  - **Security Group**: Select the one you have created previously for your web server
- **Step 6**:
  - Check your config and click on create

<h2 style="font-weight: bold;" align="right">Create Auto Scaling Group</h2>

- **Step 1**
  - Select Lauch Configuration and select the Lauch configuration created previously
- **Step 2**
  - Group Name: *WebSrvASG*
  - Group size: Start with 3 instances
  - Network: Select your vpc
  - Subnet: Select your three **private** subnet
  - Advenced Details:
    - Load Balancing: Check
    - Classic Load Balancer: Skip it
    - Target Group: Select the one created previously
    - Heatlh Check grace Period: default

After that click on next then on Review.  
Scaling policies, Notifications and Tags are useless for this hands-on but i can invite you to get more information about in the documentation.
