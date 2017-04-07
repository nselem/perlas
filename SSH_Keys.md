# SSH Installation guide
#### Important!
Make sure you can log into the machine you want to access with the SSH key. This means that such machine must have the OpenSSH Server app installed and you must have an account that allows you to log into that computer.

## 1. Generate the keys
To generate the keys, from a terminal prompt (in the computer you will use to access the remote host) enter:   
`ssh-keygen -t rsa`  
This will generate the keys using the RSA Algorithm. During the process you will be prompted for filename and a password. 
To keep it simple just press Enter or Return. The keys will be generated with a default name and no password.  

By default the public key is saved in a *.ssh* directory at your home directory using the default name *id_rsa.pub*, while the private key will be named *id_rsa*, in other words: *~/.ssh/id_rsa.pub* and *~/.ssh/id_rsa*. 

## 2. Copy the public key in the remote host
There are two ways to continue the next step (choose wisely):  

### A. The long way:
Use **scp** to copy the the public key file to your account on the remote host:  
`scp ~/.ssh/id_rsa.pub user@remotemachine:`  
You'll be prompted for your account password (type it). Your public key will be copied to your home directory (and saved with the same filename) on the remote system.  

Log into the remote system using your account username and password.  
You have to add the content of the *id_rsa.pub* file into the *authorized_keys* file.  

If your account on the remote system doesn't already contain a *authorized_keys* file (or a *.shh* directory), create one; with the following commands:  
`mkdir -p ~/.ssh`  
`touch ~/.ssh/authorized_keys`  
**NOTE:** Executing these commands will not damage an existing *.ssh* directory or *authorized_keys* file.  

Add the contents of your public key file (*id_rsa.pub*) to a new line in your *authorized_keys* file:  
`cat ~/id_rsa.pub >> ~/.ssh/authorized_keys`  

You may now safely delete the public key file from your account on the remote system:  
`rm ~/id_rsa.pub`

### B. The short way:
Copy the id_rsa.pub file to the remote host and append it to ~/.ssh/authorized_keys by entering:   
`ssh-copy-id username@remotehost`  

## That's it!
You are now able to log into your account on the remote host from the computer that has your private key (no password needed! :smiley:).

This guide was almost entirely based on:  
https://help.ubuntu.com/lts/serverguide/openssh-server.html  
https://kb.iu.edu/d/aews  
Check them for more information.
