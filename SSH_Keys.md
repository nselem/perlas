(From https://help.ubuntu.com/lts/serverguide/openssh-server.html)
## SSH Installation guide
#### Important
For the SSH keys to work, your machine must have the OpenSSH Server or Client applications (which one will depend of how your going to use your computer).

To generate the keys, from a terminal prompt enter:   
`$ ssh-keygen -t rsa`
This will generate the keys using the RSA Algorithm. During the process you will be prompted for a password. (Which you don't have to provide if you don't want to)   
Simply hit Enter when prompted to create the key. 

By default the public key is saved in the file ~/.ssh/id_rsa.pub, while ~/.ssh/id_rsa is the private key. 
Now copy the id_rsa.pub file to the remote host and append it to ~/.ssh/authorized_keys by entering: 
