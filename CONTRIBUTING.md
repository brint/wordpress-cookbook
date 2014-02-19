Contribution Guidelines
=======================

If you would like to contribute to the Chef WordPress cookbook,
you must open a ticket in [JIRA](http://tickets.opscode.com).

1. Create the ticket in the [COOK] (use "wordpress" for the component)
2. [Sign a CLA](http://wiki.opscode.com/display/chef/How+to+Contribute)

- Please do NOT modify the version number
- Please do NOT update the CHANGELOG

We will update the version number and CHANGELOG when we release a new version.

If a contribution adds new platforms or platform versions, indicate
such in the body of the commit message(s), and update the relevant
COOK ticket. When writing commit messages, it is helpful for others if
you indicate the COOK ticket. For example:

    $ git commit -m '[COOK-1041] Updated pool resource to correctly delete.'
