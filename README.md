
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

* `create_accounts.zmp` - zmprov commands to create the 100 users.
* `create_hab.zmp` - zmprov commands to create the HAB structure


```
zmprov -f create_accounts.zmp
zmprov -f create_hab.zmp
```

Create Contacts with Folders
----------------------------

Alternatively, you can just run this command to create and contacts (and folders) into an address book to show the hierarchy.

* `create_address.zmp` - zmmailbox command to add contacts and folders into an address book to show the hierarchy.
```
zmmailbox -z -m shared_user@dom.tld -f create_hab.zmp
```

Mount this Shared Contacts folder (named as Corporate address book) when you create a new user.


Add Images
----------

Add randomly created images to all the contacts in your Address Book!
NOTE: All contacts will change!

Change usename and password and URL in the `z_img.sh` file and run on your server.
````
z_img.sh
```
