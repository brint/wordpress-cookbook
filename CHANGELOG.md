CHANGELOG
=========

v1.3.2 (2014-01-23)
-------------------
* [COOK-4248] - use "no_managed_code" when setting up WordPress Pool on Windows
* [COOK-4170] - Wordpress tarball contains a wordpress subdirectory, causing "extract-wordpress" to execute every run and the WP URL to be http://hostname/wordpress/


v1.3.0
------
### Bug
- **[COOK-3478](https://tickets.opscode.com/browse/COOK-3478)** - Windows support for Wordpress


v1.2.0
------
### New Feature
- **[COOK-3321](https://tickets.opscode.com/browse/COOK-3321)** - Add languages recipe

### Improvement
- **[COOK-3311](https://tickets.opscode.com/browse/COOK-3311)** - Remove legacy Test Kitchen, Add Travis CI


v1.1.0
------
- Added Test Kitchen 1.0

Bug Fixes:
- [COOK-1393]: wordpress recipe should use mysql::ruby to ensure ruby extension is installed
- [COOK-2984]: wordpress cookbook has foodcritic failures

Improvements:
- [COOK-2661]: Allow downloads from other repos for wordpress install

v1.0.0:
-------
- [COOK-1127] - update defaults to latest version
- [COOK-1222] - support installing "latest" version
- [COOK-1271] - Wordpress cookbook generates new password on every chef run

v0.8.8
------
- [COOK-826] -  recipe doesn't quote password string

v0.8.6
------
- [COOK-534] - allow server_aliases to overridden by an attribute
- [COOK-799] - fixed disables .htaccess breaking permalink feature
- [COOK-820] - guard node.save with check for chef-solo in our cookbooks

v0.8.4
------
- [COOK-406] - wp-config.php.erb has wrong CRLF encoding
- Dropping explicit support for Red Hat platforms due to issues in php and mysql cookbooks (COOK-603, COOK-672, COOK-816, COOK-679)

v0.8.2
------
- [COOK-435] Don't set the mysql root user password in wordpress cookbook
- [COOK-535] - recursively create the directory
- RHEL/CentOS/Fedora support (yeah!)
- cleaned up node attribute keys
- cleaned up README.md
