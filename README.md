# Code-Server on Oracle Cloud Infrastructure 

[![License: UPL](https://img.shields.io/badge/license-UPL-green)](https://img.shields.io/badge/license-UPL-green) 


## Deploy Code-Server on a compute instance running on Oracle Cloud Infrastructure 

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
    
3. Click **Next** at the bottom of the screen. This will take you to the **Configure Variables** page. On this page you can provide/change these variables: 
    - **Compartment**: select the compartment where do you want to deploy the stack
    - **SSH public key** (_optional_): the key will allow you to login into the instance. 
    - **Use Always Free eligible shape**: 
        If checked, the Always Free shape (_VM.Standard.E2.1.Micro_) is used. Make sure you are in a region where this Always Free shape is available  
        If not checked:
            - **Instance Shape**: (_optional_): select the shape that will be used for the VM [default: _VM.Standard.E4.Flex_]
    - **Availability Domain**: select the Availability Domain (AD) you want the instance to be deployed to. If you have checked Always Free, make sure to select the Always Free elegible AD. 
    - ***Show Advanced***
        - **Instance Name** (_optional_): Name of the instance [_default: oci-code-server_]
        - **Flex Instance OCPUs number** (_optional_): Only if you have selected a Flex shape, you can select the number of OCPUs to assign to the flexible shape. [_default: 1_]  
    


    Then click **Next** again.

4. On the **Review** page, be sure *Run Apply* is checked, and click **Create**.

5. This will take you to the **Job Details** page, and OCI will begin creating the stack and deploying the custom image for the lab. This will take a few minutes. When it completes (assuming everything went smoothly), the **Job Details** will show a bright green square with "Succeeded" below it.

6. Go back to the **Stack Details** page, in the **Application Information** tab you can find the public IP of the instance. You can use that IP for the first login to VS Code.
    

## URLs
For more information about `code-server`: 
* [code-server](https://github.com/coder/code-server)
* [deploy-code-server](https://github.com/coder/deploy-code-server)

## Know Issues
The code-server instance is launched with the `--link ` [flag](https://coder.com/docs/code-server/latest/link) to provide  authentication through GitHub, TLS and a dedicated URL for accessing your VS Code. This feature presents some issues when you try to connect from a different geographic region than the one the instance is running and you encounter an error after the GitHub authentication. Current workaround is to use one of the other options provided by code-server guide to [expose it](https://github.com/coder/code-server/blob/main/docs/guide.md#expose-code-server): 
- using [SSH port forwarding](https://github.com/coder/code-server/blob/main/docs/guide.md#port-forwarding-via-ssh)
- using [Let's Encrypt](https://letsencrypt.org/) with [Caddy](https://github.com/coder/code-server/blob/main/docs/guide.md#using-lets-encrypt-with-caddy) or [NGINX](https://github.com/coder/code-server/blob/main/docs/guide.md#using-lets-encrypt-with-nginx)

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2024 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE.txt) for more details.

---


[![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=oracle-devrel_terraform-oci-code-server)](https://sonarcloud.io/dashboard?id=oracle-devrel_terraform-oci-code-server)
