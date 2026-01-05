## Process Management ##

#### Process ####
A running program with PID, memory, priority, and state

#### Daemon #### 
Daemon is a process that runs in backgroud continuously

#### Threads ####
Each process generates multiple threads

#### Job ####
Job or Workorder --> Run a service or process at schedule time

### Process Identification & Listing ###
👉 What is running?
#### Concepts ####

* PID (Process ID)
* PPID (Parent PID)
* User ownership

#### Commands ####

```
ps
ps aux
ps -ef
pgrep nginx
pidof sshd
```

#### Process States ####
👉 What is the process doing?

#### States ####
* R – Running
* S – Sleeping
* D – Uninterruptible sleep
* T – Stopped
* Z – Zombie

#### Commands ####

```
ps -eo pid,stat,cmd
top
```

### Real-Time Process Monitoring ###
👉 Live system view

#### Commands ####

```
top
htop
atop
watch ps aux
```

### Starting Processes ####
👉 Running programs

#### Foreground / Background ####
```
./script.sh
./script.sh &
nohup command &
screen
tmux
```

### Job Control (Shell Level) ###
👉 Terminal-controlled processes

#### Commands ####
```
jobs
bg
fg
Ctrl + Z
disown
```

### Stopping & Killing Processes ###

👉 Terminate misbehaving programs

#### Signals ####

* SIGTERM (15) – Graceful
* SIGKILL (9) – Force
* SIGSTOP / SIGCONT

#### Commands ####
```
kill PID
kill -9 PID
pkill nginx
killall java
```
### Process Priority & Scheduling ###
👉 Who gets CPU first?

#### Concept ####
Nice value (-20 to 19)

#### Commands ####
```
nice -n 10 command
renice -5 PID
top   # press r
```

### CPU & Memory Usage ###
👉 Resource consumption

#### Commands ####
```
free -m
vmstat
uptime
mpstat
pidstat
```
### Process Tree & Relationships ###
👉 Parent-child view

#### Commands ####
```
pstree
ps -ejH
ps --forest
```

### Zombie & Orphan Processes ###
👉 Broken processes

#### Concepts ####

* Zombie: finished but not cleaned
* Orphan: parent died

#### Commands ####
```
ps aux | grep Z
pstree -p
```
#### Fix ####

* Restart parent
* Reboot (last option)

### Process Limits & Control ###

👉 Prevent abuse

#### Concepts ####
* ulimit
* cgroups

#### Commands ####
```
ulimit -a
ulimit -n 4096
systemctl set-property
```

### Debugging Processes ###
👉 Why is it stuck?

#### Command ####
```
strace -p PID
lsof -p PID
pmap PID
```

### SIMPLE MEMORY FLOW ###
List → Monitor → Control → Priority → Kill → Services → Schedule → Debug
