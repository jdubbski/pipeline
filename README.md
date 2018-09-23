## Bitbucket Pipeline CI/CD Process
 

This will outline configuration steps needed in order to configure pipeline


Before you begin, it goes without saying that before you can automate anything, you must:

- fully understand the manual deployment process
- communicate with developers, understand what testing they currently do, what tools do they use, what would they like to use
- communicate with QA team and get same answers to questions above
 


  1. Go to your bitbucket repository, select 'Pipelines', Enable and select the Docker template.
  
  2. Enter code for bitbucket-pipeline.yaml file and commit.
  
  3. Go to Repository Settings, scroll down to pipeline settings at the bottom, enter in any environment variables that 
     may be needed.  Keep in mind, you do NOT want to pass in critical information in your code. This information is visible to anyone that 
     has access to your repository. USE Envrionment Variables, if you need to.
  
  4. For this use case, we will be using SSH keys to connect to the Rancher instance which is running the multiple docker containers.
  
  5. Create a cicd username on the Rancher instance. either create a keypair on instance or create thru bitbucket UI and apply the public
     key to authorized_keys file on the instance.
  
  6. On the same 'SSH keys' settings screen, enter host address of the rancher instance you will connect to, and click 'Fetch' to get
     the host's fingerprint.  This will prevent the host from getting the prompt where it expects a 'yes' response when initially connecting.

     This is a simple but can be very troublesome process. just make sure you check your keys, apply supplied keys if you need to and do a 'fetch' on the fingerprint.

  7. Test your access.  Verify security groups provide access necessary.

  8. Use the following to test from a docker container, just like what bitbucket would spin up for you:

$ docker run -it --volume=/Users/myUserName/code/localDebugRepo:/localDebugRepo --workdir="/localDebugRepo" --memory=4g --memory-swap=4g --memory-swappiness=0 --entrypoint=/bin/bash atlassian/default-image

  This will help you determine if there are any issues memory wise that could be attributing to any of your problems.  If you notice, memory is your issue, you can add 'size: 2x' to your pipeline.yaml file.

9.  My next step in this process was to create a script on the root directory of the Apache container.  There are only 3 steps, cd into /var/application, do a git pull origin development and then perform drush command: 'drush -r $DOCROOT cr'... initially this was part of bitbucket-pipeline.yaml file but appeared to not do multiple commands well, even though strung together with &&. see repository for simple deploy.sh script.  of course make sure this is executable: chmod +x
^^ this is probably due to following from bitbucket pipeline documentation:
The script for a step does not support a multi-line string yet. Please provide a list of commands
https://confluence.atlassian.com/bitbucket/troubleshooting-bitbucket-pipelines-792298903.html


pending steps:

bitbucket-pipeline should be triggered by specific branch - development.  DONE
add deployment key work to yaml file to keep track of all deployments.  DONE
when adding this to actual environment, the ssh command will need to tunnel thru bastion.
add automate testing using Gulp v3/4
add browserstack plugin
add automated QA





#
#
#
#
#
#
#
#
#
#
#
#
#
#
#

