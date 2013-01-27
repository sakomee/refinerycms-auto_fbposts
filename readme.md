# Auto Facebook Post engine for Refinery CMS.

==== Installing

Add refinerycms-auto_fbposts to your Gemfile

    gem 'refinerycms-auto_fbposts', :git => 'git://github.com/sakomee/refinerycms-auto_fbposts.git'

Run generator

    bundle exec rails g refinery:auto_fbposts

*Please check your `config/application.rb` for observer configuration*

Run migration

    rake db:migrate

==== Setup facebook and default host site from Refinery admin settings
Auto Fb App Id : Create your application in Facebook and write your App Id here. (default:iwaLab_app_id)

Auto Fb Application secret: Application secret from your application. (Default: iwaLab_application secret)

Auto Fb access Token: Access token can be created by using FB Graph API Explorer tools.

Auto Fb page Id : Any page the facebook accound can post to.

Auto Fb message: Message to display on the facebook post

Auto Fb host name: host name of your site(e.g. example.com)


==== Setup Cron Jobs
Extend life of facebook access token

By default, access token is valid for 2 hours and extended tolken for 60 days. So setup cron job to run folling task before token expires.

	rake refinery:auto_fbposts:extend_token


Setup your cron  job to run following task to post blogs in future

	rake refinery:auto_fbposts:post_to_facebook

==== License

Copyright 2013 Iwa Labs Ltd. Licensed under the MIT License.
