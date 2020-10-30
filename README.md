# HAB-c
HAB with Chinese Names

Create Users
------------

Edit the file z_ca.pl and change the domain information.

[source,bash]
----
./z_ca.pl
./z_hab.pl
----

Creates the necessary `zmprov` files to help with the creation of the accounts.
1. `create_accounts.zmp` - zmprov commands to create the 100 users.
2. `create_hab.zmp` - zmprov commands to create the HAB structure

[source,bash]
----
zmprov -f create_accounts.zmp
zmprov -f create_hab.zmp
----

Alternatively, you can also run this command to add contacts and folders into an address book to show the hierarchy.
zmmailbox -z -m shared_user@domain.tld -f create_address.zmp

2. `create_address.zmp` - zmmailbox command to add contacts and folders into an address book to show the hierarchy.

You can mount this Shared Contacts folder (Corporate address book when you create a new user.
