# This will outline configuration steps needed in order to configure pipeline
# 


#  1. Go to your bitbucket repository, select 'Pipelines', Enable and select the Docker template.
  
#  2. Enter code for bitbucket-pipeline.yaml file and commit.
  
#  3. Go to Repository Settings, scroll down to pipeline settings at the bottom, enter in any environment variables that 
     may be needed.  Keep in mind, you do NOT want to pass in critical information in your code. This information is visible to anyone that 
     has access to your repository. USE Envrionment Variables, if you need to.
  
#  4. For this use case, we will be using SSH keys to connect to the Rancher instance which is running the multiple docker containers.
  
#  5. Create a cicd username on the Rancher instance. either create a keypair on instance or create thru bitbucket UI and apply the public
     key to authorized_keys file on the instance.
  
#  6. On the same 'SSH keys' settings screen, enter host address of the rancher instance you will connect to, and click 'Fetch' to get
     the host's fingerprint.  This will prevent the host from getting the prompt where it expects a 'yes' response when initially connecting.

     This is a simple but can be very troublesome process. just make sure you check your keys, apply supplied keys if you need to and do a 'fetch' on the fingerprint.

#  7. Test your access.  Verify security groups provide access necessary.

#  8. Use the following to test from a docker container, just like what bitbucket would spin up for you:

$ docker run -it --volume=/Users/myUserName/code/localDebugRepo:/localDebugRepo --workdir="/localDebugRepo" --memory=4g --memory-swap=4g --memory-swappiness=0 --entrypoint=/bin/bash atlassian/default-image

#  This will help you determine if there are any issues memory wise that could be attributing to any of your problems

#9.  My next step in this process was to create a script on the root directory of the Apache container.  There are only 3 steps, cd into /var/application, do a git pull origin development and then perform drush command: 'drush -r $DOCROOT cr'... initially this was part of bitbucket-pipeline.yaml file but appeared to not do multiple commands well, even though strung together with &&. see repository for simple deploy.sh script.  of course make sure this is executable: chmod +x



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

