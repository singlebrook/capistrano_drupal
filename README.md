=Drupal Deployment via Capistrano=

This is basic structure for deploying your Drupal applications to your staging and production sites using the popular Ruby library, Capistrano.

Though Capistrano is most famously used to ease the annoyances involved in Rails deployments, it's actually quite easy to use this with other web applications.  Here we offer our setup for Drupal applications.

==Requirements on your development machine==

  * Ruby and Ruby Gems
  * Capistrano 2.x (sudo gem install capistrano)
  * The following Capistrano plugins (both Gems):
    * capistrano-ext (sudo gem install capistrano-ext)
    * railsless-deploy (sudo gem install railsless-deploy)

==Assumptions==

Note: none of these assumptions are required to use Capistrano, but they are required in order to use this script without modifications.

This code assumes you're using Git for your VCS, and that your code is hosted on a server you have SSH access to.  We also assume you have two remote branches: development and master.  The development branch is used to deploy to your staging site, and your master branch is used to deploy to your production instance (mutli-stage deployment).  Settings for each stage of deployment are located in the config/deploy directory of this project.

Also, we assume that you have created a /shared/ directory where you deploy your application.

i.e. if our application is deployed to /var/www/vhosts/staging.abcdinosaur.com/, we'd have a directory /var/www/vhosts/staging.abcdinosaur.com/shared/.  This contains a 'sites/default' directory, which contains the settings.php file for Drupal on our server, and the 'sites/default/files' directory, which holds uploaded content.  Neither of these should be versioned or located in the releases directory, since they persist from deployment to deployment.  We symlink this directory to the proper files in our deployment script.

==Installation==

Either copy or git clone this repository into the root directory of your Drupal project and add your deployment-specific settings to the deploy.rb, production.rb, and staging.rb files.


==Usage==

Setup the proper directory structure on your server:

  $ cap staging deploy:setup

Then deploy:

  $ cap staging deploy

See the Capistrano wiki for more info (https://github.com/capistrano/capistrano/wiki).