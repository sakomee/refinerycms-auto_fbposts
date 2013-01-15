# Auto Facebook Post engine for Refinery CMS.

## Installing

Add refinerycms-auto_fbposts to your Gemfile

    gem 'refinerycms-auto_fbposts', :git => 'git://github.com/sakomee/refinerycms-auto_fbposts.git'

Run generator

    bundle exec rails g refinerycms_auto_fbposts

*Please check your `config/application.rb` for observer configuration*

Run migration

    bundle exec rake db:migrate

#Setup facebook and default host site from Refinery admin settings
Auto Facebook access Token: Access token can be created by using FB Graph API Explorer tools.
Auto Facebook page Id : Any page the facebook accound can post to.
Auto Facebook message: Message to display on the facebook post
Auto Facebook host name: host name of your site(e.g. example.com)




## License

Copyright 2013 Iwa Labs Ltd. Licensed under the MIT License.
