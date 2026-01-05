### Basic Categories of Linux Commands
* File and Directory management
* System information
* Hardware information
* Performance monitoring and statistics
* Process management
* Networking
* Archives ( zip, tar )
* Install and uninstall packages
* Search
* File transfers
* Security




## SEARCH CATEGORY ##

### 1- find command ###

**Description:** Search for files and directorie on behalf of multiple arguments

***syntax***

*find [path...] [expression].*

***Find the file which has 777 permissions***

`find . -type f -perm 0777 -print` 

***Find the empty file in tmp directory** 

`find /tmp -type f -empty`

***Find the files which has txt extention and remove those files if found***

`find . -type f -name "*.txt" -exec rm -f {} \;`

***Find the file whose owner is root name is test.txt***

`find / -user root -name test.txt`

***Find the file whose group is developer name is test.txt***

`find /home -group developer `

***Find the file having size more than 50MB and less that 100MB***

`find / -type f -name *.mp3 -size +10M -exec rm {} \;`

***Find Files and Directories Based on Date and Time. Here n is the time***

* `+ n = For greater than n.`
* `- n = For less than n.`
*   `n = For exactly n.`

***Arguments for access time #  (Access time): This is the time when the file was last accessed***

* `-amin n = time in minutes`
* `-atime n = time in days.` n*24 hours ago. means multiply given time with 24 hours and then find the file

***Arguments for changed time # (Change time): This is the time when changes were made to the file’s metadata.***

* `-cmin n = change time in minutes`
* `-ctime n = changed time in days.` n*24 hours ago. means multiply given time with 24 hours and then find the file

***Arguments for modified time #  (Modification time): This is the time when the contents of the file were last modified.***

* `-mtime n = modified time in minutes`
* `-mmin n = modified time in days.` n*24 hours ago. means multiply given time with 24 hours and then find the file

***Find the files in current directory which were modified after 2023-12-21 but not modified after 2023-12-22 and copy them into /home/munawar/dr-images folder***

`cp $(find . -type f -newermt "2023-12-21" ! -newermt "2023-12-22") /home/munawar/dr-images /`

### 2- grep/egrep command ###

**Description:** Search pattern/text. It is used to search the content in a file or files in any directory. If you want to search the specific content/text and you know or don't know about the file.

***syntax***

*grep options/switches -e "patteren" path*

* grep -i(ignore case sensitive) for Lower and uppercases grep -i -n ROOT /etc/passwd
* grep -n: print the line numbers
* grep -o: only pattern grep -o /etc/passwd
* grep -v: print line that does not match the patteren
* grep -w: match exact word only 
* grep -n -A2: print next 2 lines after the result
* grep -n -C3: print 3 before and after of matched text
* grep -r: recursive search for a patteren
* grep -nw -A2 -B2 "chmod 700" monit
* grep -l: list the files that contains the matching word. e.g `grep -l "hello" *.txt`
* grep -lr: find the all files in the given path which contains the specific word. e.g `grep -rl "heloo" /`
* find specific word in any file `grep -rnw /opt/onezapp/glassfish/ -e "oneload"`

### 3- sed command ###

**Description:** Search/find text, insert, delete, replace, Append before or after the line

***syntax***

*sed 'action' filename*

*basics*

* ` ; used for "and" like print 1 and 2 line sed -n '1p;2p' /etc/shadow`
* ` , used for range linke print 1-5 lines  sed -n '1,5p' /etc/shadow`
* ` $ used for last number. print last line sed -n '$p' /etc/shadow`
* ` p used to print`
* ` n used to give the line numbers to the output`
* ` d used to delete`

***Examples***

* print 1-3 and 5 and 7 and 9-11 lines `sed -n '1,5p;7p;9,11p' /etc/shadow`
* Print lines with interval `cat -n /etc/shadow |sed -n '1~3p'`
* Print lines with multiple range `cat -n /etc/shadow |sed -n '2,5p;8,11p'`
* Delete 4th line of a file `sed '4d'`
* Delete lines with range `sed '4,8d'`
* Delete empty lines `sed '/^$d/'` filename`
* Delete lines that has # in start `sed '/^#/d' filename`
* Delete lines that have # in start and also remove empty line with a single command `sed '/^#\|^$d' filename`
* Find logs between two dates `sed -n '/17:2[0-9]:/,/18:4[0-9]:/p' filename`

***find and replace using sed command***

***syntax***

*sed 's(substitute/replace)/find(find this word)/replaceby(replace with this word)/g(gloably)' /passwd(file name)*

***Examples***

* Replace root word with munawar `sed 's/root/munawar/g' /etc/passwd`
* Replace only in line number 1 `sed '1s/root/munawar/g' /etc/passwd`
* Replace word in 1-10 lines `sed '1,10s/root/munawar/g' /etc/passwd`
* If same word repeated 3 times in a line and we want to replace 2nd word then do `sed 's/root/munawar/2' /etc/passwd`
* Replace multiple words using same commad. ***1.*** `sed 's/root/munawar/g;s/raza/munawar/g'`***2.*** ` sed 's/root/munawar/g' -e 's/raza/munawar/g' /etc/passwd`

### 4- cut command ###

**Description:** Print the text column vise

***syntax***

*sed 'action' filename*

*basics*

* ` -c used to print the characters`
* ` -f : cut by fields. we can not use this option with out defining the delimiter sysmbol that is ***-d***`
* ` -d : delimiter. used to decide the filed: like jo value is man den gy wo filed concider ho gi`

***Examples***

* Print first character `cut -c1 /etc/passwd`
* Print first and fifth character ` cut -c1,5 /etc/passwd`
* Print 3rd to 7th characters ` cut -c3-5 /etc/passwd`
* Print the fileds having ***:***. `cut -d':' -f1`. It means concider the ***:*** as delimiter. rows man jahan jahan ***:*** aae ga wahan tak ak filed ho gi. ***-f1*** is used to print the first field
* Print the range of fileds. `cut -d':' -f1-3`. It will print first, second and third columns
* Print first and third columns. `cut -d':' -f1,3`.
* Print the fileds having space between words. `cut -d' ' -f1 filename`
* Print the IP address `ip a |sed -n '9p' |cut -d' ' -f6-8 |cut -d'/' -f1`

### 5- awk command ###

**Description:** It is the advancement of cut command

***syntax***

*awk options 'selection_criteria/patteren {action}' input_file*
*awk options(-F,etc) '{}'*

*basics*

* ` -F used as delimeter like -d in cut command`
* ` NF Number of fileds/words in a row.`
* ` $NF used to print the last filed`
* ` NR used to print the number of rows`
* ` RS (Record seperator). Each line is a record. Record seperator means how the lines are seperated. by default each line is seperated by` ***\n so RS='\n'***
* ` FS (Field seperator). Any number of space or tab charator. In a line, each word is a field. So the space between these words is called field seperator`

***Examples***

* Print first filed of every line. `awk ' {print $1}' filename`
* `awk ' {print }' test.txt or awk '{print $0}' test.txt`
* `awk '/proxy/ {print}' /etc/passwd or awk '/proxy/ {print $0}' /etc/passwd`

***Regex in AWK***
* `awk '/^u/ {print $0}' test.txt 
* `awk '/^[st]/ {print $0}' test.txt 
* print if field(word) 3 contains given patteren `awk '$3 ~ /o/ {print $0}' test.txt`
* print if field(word) 3 does not contain given patteren `awk '$3 !~ /o/ {print $0}' test.txt`
* print specific fields if field(word) 3 contains given patteren `awk '$3 ~ /make/ '{print $4,$5}' test.txt`
* `awk '$3 > 100 {print $1}' test.txt`
* `awk ' {print NR,"-----","(",NF,")",$0}' test.txt`

### 6- dd command ###

**Description:** Copy the content of a file from one directory to another file in another directory. ***Note:*** dd only works with files not with directories

***syntax***

*dd if=source_file of=destination_file*

***Examples***

* Create a file of size 24M. `dd if=/dev/zero of=output.dat  bs=24M  count=1`
	*Here, “bs” stands for “block size”. When dd is writing data, it writes in blocks. Using this option, the block size can be defined. In this case, the value “1M” says that the block size is 1 megabyte “count” decides the number of blocks to be written. If not fixed, “dd” will continue the writing process unless the input stream ends. In this case, “/dev/urandom” will continue generating data infinitely, so this option was paramount in this example*

---

## Special Permissons ##

* Sticky Bit ( 1 ): No one can delete the content of the directory except the owner
* SetGID (2): Group ownership will be inherited to all the content of the directory. Everyfile/directory's group name will be changed
* chmod g+s directory_name
* SetUID(4): Command will be run with owner rights instead of the rights of the executer. Every File will be 
* chmod u+s directory_name

* w = only can write the file but if this single permission is given, it can't do any thing. To perform operations it should be given execute permission.
* r = only can read the content instead of going into directory, With this permission usre can list the files/directories from the main instead of going into it
* x = only can enter into the directory and can't perform any action in the directory


---

## Regex/Regular expressions ##

* ***`.(dot): Any one character`***
* ***`*(Asterisk): Match zero or more occurrence of the previous char`***
* ***`?(question mark): Match zero or one occurrence of the previous char ex jpe?g`***
* ***`+(plus): Match one or more occurrence of the previous char`***
* ***`[]: Character class`***
* ***`{}: specific the Minimum and maximum occurances of previous character or character-class`***
* ***`(): Group some words`***

***dot( . ) Regex*** 

***Usage:*** Match any one character. Does not matter which alphabet/character class or group it is

* `egrep "..." filename`   matches if at least 3 characters are there
* `egrep "leaf." filename` matches at least 1 character should be after leaf
* `egrep ".nix" filename`  matches at least one character should be before nix, like unix, anix, fanix, 
* `egrep "a.t" filename`   matches at least one character should be there between the "a and t" like ant, act etc

***Asterisk( \* ) Regex***

***Usage:*** Match Zero or many occurance of previous character or character-class (previous cherecter 0 dafa aae ya phr jitni merzi dafa aae).For instance

* `egrep "a*c" filename` Match ***a*** zero or more times before ***c***. For example, `ac, aac,aaac, c, bc, bbbbbc, 1111c, aaaaac.` In this example any alphabet can come before ***c***, ***a*** may or may not come before ***c***. It does not matter how much time a character is comming before ***c***.
* `egrep "a.*c" filename` Match any thing between ***a and c***. For example, `abc, abbc, addddc, adc, adddc`. Any alphabet can come between ***a and c*** but in any case first alphabet should be ***a*** and last alphabet should be ***c***. For example, if ***b*** is comming before ***c***, it does not matter how many time it is comeing. It can be 1,2,3,4...times
* `egrep "(ac).*z" filename` # matches anything between ac and z. For example `acbz, acbbz, acccz, ac11z, ac3333z`.

***Question mark( ? ) Regex***

***Usage:*** Match zero or 1 occurance of previous character or character-class (previous cherecter aae hi na ya phr ak bar aae bs. not more than 1 times).For instance

* `egrep "colou*r" file` In this ***u*** may not come, if it is comming then only 1 time. e.g color, colour.
* `egrep "Mrs? Raza" filename`  It will match the Mrs and Mr both

***Plus( \+ ) Regex***

***Usage:*** Match 1 or more occurance of previous character or character-class (previous cherecter must be at least 1 time).For instance

* `egrep "colou*r" file` Match ***u*** atleast 1 time. e.g colour, colouur, colouuur


***Character Class( [ ] ) Regex***

***Usage:***

* 'egrep "[abcd]" filename` Matches if any one of the characters within square brackets are present
* `egrep "[a-f]" filename`  Matches if any character within the a-f RANGE is present
* `egrep "practi[cs]ing" filename` Matches practicing and practising
* `egrep "app[12]" filename` Matches app1 and app2 not apps
* `egrep "[^123]" filename`  Matches if there is any character other than 1-3
* `egrep "^[^0-9]" filename` Matches if line does not start with number

***Character Class( { } ) Regex***

***Usage:*** indicate specific, Minimum and maximum occurances of  previous character or character-class

***Grouping ( ) Regex***

***Usage:*** Make the group of some characters.

* `egrep "(cs)" filename` find the word which has "cs"
* `egroup "(iss)" filename` Now the words that have iss will be matched

***Alternate ( | ) Regex***

***Usage:*** Make choices

* `egrep "a|b|c" filename`
* `egrep "(ab|cd|ef)a" filename`

***start of string ( ^ )***

***Usage:*** Start of string or line

* `egrep "^UNIX" filename` Match if line started with UNIX
* `egrep "^[AB]" filename` Matches if line started with A or B

***An example*** 

* `egrep "[A-Za-z.]{1,}@[A-Za-z.]{1,2}.[A-Za-z]{3}.(pk)" regular.txt`


---

## Redirections ##

* `0 - stdin`  It takes the text as input
* `1 - stdout` It means output. Whenever any command-line utility is run, it generates two outputs. The output goes to stdout and the error (if generated) goes to stderr. By default, both these data streams are associated with the terminal.
* `2 - stderr` It means error

***Note***: >& is the syntax to redirect a stream to another file descriptor

***Examples***

* Redirect the stderr into a text file. `asdfadsa 2> error.txt`
* However, we don’t want to see all those successful ping results. Instead, we only want to focus on the errors when ping couldn’t reach Google. How do we do that? `ping google.com 1> /dev/null`
* Redirect stdout to a file.txt. `hostname > file.txt or hostname 1> file.txt`
* Redirect stderr to file.txt `hostnam 2>file.txt`
* Redirect output(stdout) and error(stderr) to a file. `hostname >file_name 2>&1`
* Redirect stdout to stderr. `echo test 1>&2 or echo test >&2`
* Redirect stderr to stdout. `echo test 2>&1`. ***explaination***. Here, ***2>*** redirects stderr to an (unspecified) file and ***&1*** redirects stderr to stdout.
* If we want to show that if we execute a command and we got an error, that should be as output then we use following command. ` eco test 2>&1`

---

## Special variables ##

* $0 - The name of the Bash script.
* $1 - $9 - The first 9 arguments to the Bash script. (As mentioned above.)
* $@ - All the arguments supplied to the Bash script.
* $# - How many arguments were passed to the Bash script.
* $$ - The process ID of the current script.
* $? - The exit status of the most recently run process.
* $* - If you want to see what paramerter are passed to the script we can use this e.g ./test.sh /var/log if we want to see what value was passed i.e /var/log
* break
* continue
* basename: strip the directory info and only give filename
* dirname: strip the filename and only give directory path
* realpath: gives full path for a file
* $SECONDS - The number of seconds since the script was started.
* $RANDOM - Returns a different random number each time is it referred to.
* $LINENO - Returns the current line number in the Bash script.

Reference: *https://ryanstutorials.net/bash-scripting-tutorial/bash-variables.php*

---

## Common Commands ##

***load test on a url***

* siege -c 2 -r 2 https://portal-uat.onezapp.pk
	* -c 2 : number of users
	* -r 2 : number of requests can be made by each user
* ab -n50 -c10 https://portal-uat.onezapp.pk/auth/login

***Check/Calculate count and time in webserver logs***

* grep "23/Jan" progolfdeal.com | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c

***Check/Calculate most repeated IPs in webserver logs***

* grep "12/Sep" access.log |awk '{print $1,$4}'  |awk -F: '{print $1,$2":00"}' |sort -n |uniq -c |sort -n |tail -n 30 |awk 'BEGIN {print "Count IP Time\n"}{print $1,$2,$4}' |column -t


***Find/check Top Running Processes by Highest Memory and CPU Usage in Linux***
* ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head

***Check which process is taking how much ram***

* ps aux --sort=-%mem | head

***Check the size of directory/file***

* Print large directories `du -a -c -h /var/log/ | sort -n -r | head -n 10`
* Print large directories `du -hs * | sort -rh | head -5`
* Print largest file size `find / -type f -exec du -Sh {} + | sort -rh | head -n 5`

Reference: *https://www.tecmint.com/find-top-large-directories-and-files-sizes-in-linux/*

***Update key in ubuntu***

* sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6494C6D6997C215E

***Check imported keys in centos***

* Print all keys: `rpm -q gpg-pubkey --qf '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n'`
* Remove any unwanted key: `rpm -e gpg-pubkey-b6792c39-53c4fbdd`

Reference: *https://linuxconfig.org/how-to-list-import-and-remove-archive-signing-keys-on-centos-7*

***How to take backup of linux***

* rsync -aAXv / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /mnt

***Check systemd services***

* systemctl list-units --type service --all
* chkconfig --list
* systemctl list-unit-files


***Clear Cache of RAM***

* ps -o pid,user,%mem,command ax | sort -b -k3 -r
* sync; echo 1 > /proc/sys/vm/drop_caches
* sync; echo 2 > /proc/sys/vm/drop_caches
* sync; echo 3 > /proc/sys/vm/drop_caches

References:
	*https://www.tecmint.com/clear-ram-memory-cache-buffer-and-swap-space-on-linux/*
	*https://upcloud.com/community/tutorials/troubleshoot-linux-memory-issues/*
	*https://net2.com/how-to-fix-high-memory-usage-in-linux/*

***Clear apache2 cache***

* /usr/bin/htcacheclean -d 120 -p /var/cache/apache2/mod_cache_disk -l 300M -n

Reference: *https://www.howtoforge.com/caching-with-apaches-mod_cache-on-ubuntu-10.04*

***How to create file with custome size***
* Create File: `yes hy | head -c 10G > file.txt`
* Truncate File: `truncate -s [file-size]/100M [name of the file]`

Reference: *https://www.computernetworkingnotes.com/linux-tutorials/generate-or-create-a-large-text-file-in-linux.html*

***Add static routes in centos***

* add using command: `ip route add 192.168.10.0/24 via 192.168.50.1 dev ens33`
* add in file: `nano /etc/sysconfig/network-scripts/route-eth0 --> 192.168.10.0/24 via 192.168.50.1 dev ens33`

***Add static routes in Windows***

* route ADD destination_network MASK subnet_mask  gateway_ip metric_cost
* route ADD 192.168.35.0 MASK 255.255.255.0 192.168.0.2
* route add -p 10.13.31.105 MASK 255.255.255.255 172.16.142.245 1

***Telnet vs SSH***

Telnet: Telnet is a protocol that is used to access the remote server as we do using ssh in telent all text is being sent in clear text form. no encryption is placed.

SSH: It is also a protocol that is used to access the remote server shell. It is secure

***SMTP vs IMAP***

SMTP: this is used to send email from a server

IMAP: This is used to receive eamils

***Command autofill in centos***

* sudo yum -y install bash-completion

***Install Specific version of a package in centos***

* yum clean all
* yum --showduplicate list [package_name]
* yum install [package-name]-[version].[architecture]
* yum install firefox-31.5.3-3.el7_1.x86_64

Reference: *https://www.thegeekdiary.com/centos-rhel-how-to-install-a-specific-version-of-rpm-package-using-yum/*

***Remove login message in Ubuntu***

* Remove legal file: `mv /etc/legal /etc/legal.old`
* Remove last login messages: `rm -rf /var/logs/lastlogin`

***Logout other users***

* Show who is logged in: `who`
* Enter this command: `pkill -KILL -u {username}` ***e.g*** `pkill -KILL -u munawar`

***sudoers files is corrupted***

Problem: /etc/sudoers file corrupted and I can't run 'pkexec visudo' over SSH

Solution: 

Open two ssh sessions to the target server. In the first session, get the PID of bash by running: `echo $$`. In the second session, start the authentication agent with: `pkttyagent --process (pid from step 2)`

Back in the first session, run: `pkexec visudo` In the second session, you will get the password prompt. visudo will start in the first session.

Reference: *https://askubuntu.com/questions/799669/etc-sudoers-file-corrupted-and-i-cant-run-pkexec-visudo-over-ssh*

***Give sudo permissions for a specific command to a user***

sudo vim /etc/sudoers

```
Cmnd_Alias DA_TE = /usr/bin/date
username ALL=(ALL) NOPASSWD: DA_TE
```

sudo date -s "19 APR 2012 11:14:00"

