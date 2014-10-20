APP_NAME=rhconvergence

clear

echo
echo "##############################################################"
echo "##                                                          ##"   
echo "## Setting up the Participant Sign-in Sheet  OpenShift Demo ##"
echo "##      App Name=$APP_NAME                                  ##"   
echo "##                                                          ##"   
echo "##  brought to you by Evong Nham                            ##"   
echo "##                                                          ##"   
echo "##############################################################"
echo

#create new rails project
#rhc create-app $APP_NAME ruby-1.9 mysql-5.5
scl enable ruby193 "rails new $APP_NAME"
cd $APP_NAME
cp ../install/Gemfile .
scl enable ruby193 "rails generate scaffold participant first_name:string last_name:string email_address:string"
cp ../install/database.yml config/
cp ../install/deploy .openshift/action_hooks
cp ../install/index.html.erb app/views/participants/
cp ../install/application.html.erb app/views/layouts/
#cp ../install/routes.rb config/
sed -i '2i\  root :to => "participants#index"' config/routes.rb
rm -f public/index.html
#touch .openshift/markers/force_clean_build
scl enable ruby193 "bundle install"
#git add .
#git commit -m "Initial commit"
#git push
#echo "Complete... your app is now available."
