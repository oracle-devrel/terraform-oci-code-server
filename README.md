# Code-Server on Oracle Cloud Infrastructure 

[![License: UPL](https://img.shields.io/badge/license-UPL-green)](https://img.shields.io/badge/license-UPL-green) [![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=oracle-devrel_terraform-oci-code-server)](https://sonarcloud.io/dashboard?id=oracle-devrel_terraform-oci-code-server)

## Deploy Code-Server on OCI VM 

One-click button deploy to deploy [code-server](https://github.com/cdr/code-server) on Oracle Cloud Infrastructure compute instance.

## Introduction
This project enables you to create and configure network and compute resources on OCI and launch a code-server instance.

## Architecture Diagram

![code-server deployment architecture diagram](docs/images/tf-code-server.png)

### Prerequisites
- Oracle Cloud account

## Getting Started


1. Click the button below to begin the deploy of code-server:
    
    <a href="https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/oracle-devrel/terraform-oci-code-server/releases/latest/download/oci-deploy-code-server-latest.zip" target="_blank"><img src="https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg" alt="Deploy to Oracle Cloud"/></a>

2. If needed, log into your account. You should then be presented with the **Create Stack** page. 
    
    These next few steps will deploy a stack to your OCI tenancy. This will include a virtual clod network and a compute instance and the necessary configurations to deploy and run code-server from within your OCI account.

    Under *Stack Information* (the first screen), check the box *I have reviewed and accept the Oracle Terms of Use*. Once that box is checked, the information for the stack will be populated automatically.
    
3. Click **Next** at the bottom of the screen. This will take you to the **Configure Variables** page. On this page you can optionally provide/change these variables: 
    - **Compartment** (_optional_): select the compartment where do you want to deploy the stack
    - **SSH public key** (_optional_): the key will allow you to login into the instance. 
    - **Instance Name** (_optional_): Name of the instance [_default: oci-code-server_]
    - **Shape** (_optional_): Instance shape [_default: VM.Standard.E4.Flex_]. If you want your Compute instance to function after your Free Trial ends, check the box for an Always Free Shape. 
    - **OCPUs number** (_optional_): Only if you have selected a Flex shape [_default: 1_]
    

    
    Then click **Next** again.

    ![Configure Variables](./docs/red-bull-hol-configure-variables.jpg)
4. On the **Review** page, be sure *Run Apply* is checked, and click **Create**.

    ![Review and Create](./docs/red-bull-hol-1c-create-stack-review.jpg)
5. This will take you to the **Job Details** page, and OCI will begin creating the stack and deploying the custom image for the lab. This will take about 11 minutes. When it completes (assuming everything went smoothly), the **Job Details** will show a bright green square with "Succeeded" below it.
    
    ![Create Stack Succeeded](./docs/red-bull-hol-1d-create-stack-succeeded.jpg)
6. Once the Create Stack job has succeeded, click the hamburger menu in the upper left, select **Compute** in the sidebar, and click **Instances** in the menu.

    ![Instances in the Menu](./docs/red-bull-hol-2a-menu-instances.jpg)
7. On the **Instances** screen, make sure "redbullhol" is selected under *Compartment*. If "redbullhol" isn't in the dropdown menu, it may need some time to show up, so grab (another) cup of coffee/tea and check back in a few minutes.

    ![Instances Compartment](./docs/red-bull-hol-2c-instances-compartment.jpg)
8. Once the "redbullhol" compartment is selected, you should see a running Instance in the list. The address you'll need to access it is in the *Public IP* column. Copy the IP address shown.

    ![Public IP](./docs/red-bull-hol-2d-instances-public-ip.jpg)
9. Next, open a new tab in your browser to load up the web UI for Jupyter Lab. Paste the IP address you just copied with `:8888` added to the end. The URL should look like `https://xxx.xxx.xxx.xxx:8888` (substituting the public IP we copied in the previous step). Jupyter Lab is running on port 8888, so when you navigate to this URL you should see the Juypter login.

    _**Note:** You should not be on VPN when opening Jupyter Lab._

    ![Jupyter Login](./docs/red-bull-hol-3b-jupyter-login.jpg)
10. Log in with the jupyter token and assign a password like `Redbull1`.
11. You should now see the Jupyter Lab. Navigate in the sidebar to `/redbull-analytics-hol/beginners/` to see the Jupyter notebooks for this lab.

The notebooks are numbered and you'll progress through them in order. These will walk you through collecting and analyzing the data we'll use to predict some races.

## URLs
For more information about `code-server`: 
* [code-server](https://github.com/coder/code-server)
* [deploy-code-server](https://github.com/coder/deploy-code-server)

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2021 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.
