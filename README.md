
HAB with Chinese Names
----------------------

Create Users
------------

Edit the file z_ca.pl and change the domain information.

```
./z_ca.pl
./z_hab.pl
```

Creates the necessary `zmprov` files to help with the creation of the accounts.

. `create_accounts.zmp` - zmprov commands to create the 100 users.
. `create_hab.zmp` - zmprov commands to create the HAB structure


```
zmprov -f create_accounts.zmp
zmprov -f create_hab.zmp
```

Alternatively, you can also run this command to add contacts and folders into an address book to show the hierarchy.
zmmailbox -z -m shared_user@domain.tld -f create_address.zmp

. `create_address.zmp` - zmmailbox command to add contacts and folders into an address book to show the hierarchy.
```
zmmailbox -z -m shared_user@dom.tld -f create_hab.zmp
```

You can mount this Shared Contacts folder (named as Corporate address book) when you create a new user.
