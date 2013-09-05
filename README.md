Chef Wordpress Cookbook
=======================
The Chef Wordpress cookbook installs and configures Wordpress according to the instructions at http://codex.wordpress.org/Installing_WordPress.

This cookbook does not set up the WordPress blog. You will need to do this manually by going to http://hostname/wp-admin/install.php (this URL may be different if you change the attribute values).


Installation
------------
Install the cookbook using knife:

    $ knife cookbook site install wordpress

Or, if you are using Berkshelf, add the cookbook to your Berksfile:

```ruby
cookbook 'wordpress'
```


Usage
-----
Add the cookbook to your `run_list` in a node or role:

```json
{
  "run_list": [
    "recipe[wordpress::default]"
  ]
}
```

Or include it in a recipe:

```ruby
# other_cookbook/metadata.rb
# ...
depends 'wordpress'
```

```ruby
# other_cookbook/recipes/default.rb
# ...
include_recipe 'wordpress::default'
```

If a different version than the default is desired, download that version and get the SHA256 checksum (sha256sum on Linux systems), and set the version and checksum attributes.


Attributes
----------
<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Example</th>
      <th>Default</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>version</td>
      <td>version of the wordpress to install</td>
      <td><tt>1.2.3</tt></td>
      <td><tt>'latest'</tt></td>
    </tr>
    <tr>
      <td>checksum</td>
      <td>sha256sum of the tarball</td>
      <td><tt>abcd1234</tt></td>
      <td><tt>''</tt></td>
    </tr>
    <tr>
      <td>dir</td>
      <td>location for wordpress files</td>
      <td><tt>/nfs/wp</tt></td>
      <td><tt>/var/www</tt></td>
    </tr>
    <tr>
      <td>database</td>
      <td>name of the database to use</td>
      <td><tt>bob-wordpress</tt></td>
      <td><tt>wordpressdb</tt></td>
    </tr>
    <tr>
      <td>user</td>
      <td>the user to connect to MySQL</td>
      <td><tt>user</tt></td>
      <td><tt>wordpressuser</tt></td>
    </tr>
    <tr>
      <td>password</td>
      <td>the password to connect to MySQL</td>
      <td><tt>P@s$w0rD</tt></td>
      <td><tt>(randomly generated)</tt></td>
    </tr>
    <tr>
      <td>server_aliases</td>
      <td>server aliases for Apache</td>
      <td><tt>['foo.com']</tt></td>
      <td><tt>[(node's FQDN)]</tt></td>
    </tr>
  </tbody>
</table>


Attributes will probably never need to change (these all default to randomly generated strings):

* `node['wordpress']['keys']['auth']`
* `node['wordpress']['keys']['secure_auth']`
* `node['wordpress']['keys']['logged_in']`
* `node['wordpress']['keys']['nonce']`


Development
-----------
This cookbook uses Test Kitchen (1.0). To run the tests, clone the repository, install the gems, and run test kitchen:

    $ git clone git://github.com/opscode-cookbooks/wordpress.git
    $ cd wordpress
    $ bundle install
    $ bundle exec strainer test

1. Fork the cookbook on GitHub
2. Make changes
3. Write appropriate tests
4. Submit a Pull Request back to the project
5. Open a [JIRA ticket](https://tickets.opscode.com), linking back to the Pull Request


License & Authors
-----------------
- Author:: Barry Steinglass (barry@opscode.com)
- Author:: Joshua Timberman (joshua@opscode.com)
- Author:: Seth Chisamore (schisamo@opscode.com)

Copyright:: 2010-2011, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
