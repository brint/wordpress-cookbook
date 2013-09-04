CHANGELOG
=========

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
