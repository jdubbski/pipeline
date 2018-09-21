echo "Deploy script started"
cd /var/application
git pull origin development
drush -r $DOCROOT cr
echo "Deploy script finished"


