# raspberry-pi-motd

## Message of the Day for the Raspberry Pi ####

All the work below is my customisation of motd from the forum thread on [raspberrypi.org](https://www.raspberrypi.org/forums/viewtopic.php?t=23440)


### motd1.sh:
<p align="center">
  <img src="https://github.com/yoannportugal/raspberry-pi-motd/blob/master/motd1.png"/>
</p>

### motd2.sh:
<p align="center">
  <img src="https://github.com/yoannportugal/raspberry-pi-motd/blob/master/motd2.png"/>
</p>

### motd3.sh:
<p align="center">
  <img src="https://github.com/yoannportugal/raspberry-pi-motd/blob/master/motd3.png"/>
</p>

### motd4.sh:
<p align="center">
  <img src="https://github.com/yoannportugal/raspberry-pi-motd/blob/master/motd4.png"/>
</p> 

### motd5.sh:
<p align="center">
  <img src="https://github.com/yoannportugal/raspberry-pi-motd/blob/master/motd5.png"/>
</p> 

### motd6.sh: same than 4 with undervoltage info

Written in bash and tested with the Raspbian distribution.

- Create file `motd.sh` in `/etc`

```bash
sudo nano /etc/motd.sh
```
Use one of the 2 different motd layout to fill this file.

- Change owner and make it executable: 

```bash
sudo chown root:root /etc/motd.sh && sudo chmod +x /etc/motd.sh
```

- Add `/etc/motd.sh` as the last line in your `~/.profile` to execute the script when the user logs in via a tty console or ssh.


- Remove the original motd file: 

```bash
  sudo rm /etc/motd
```


You can remove the "last login" information. However it is considered a security risk. If you wish to do so, you should disable the `PrintLastLog` option from the `sshd` service. Edit the `/etc/ssh/sshd_config` file and uncomment the line `#PrintLastLog yes`:
  
  ```bash
  sudo nano /etc/ssh/sshd_config
  ```
  
  Before:
  
  ```text
  #PrintLastLog yes
  ```
  
  After:
  
  ```text
  PrintLastLog no
  ```
  
  Restart the `sshd` service:
  
  ```bash
  sudo /etc/init.d ssh restart
  ```
Now simply SSH into the Pi and enjoy the new motd.

Note: If you don't see the degree Celsius character correctly (`º`) make sure you have enabled a UTF8 locale.


`motd2.sh` is copied from Retropie (Replaced Joystick with Raspberry Logo).

The ASCII logo came from a forum thread on [raspberrypi.org](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=5494#p78678)


Auto installation:
```
git clone https://github.com/yoannportugal/raspberry-pi-motd
sudo chown root:root /home/pi/raspberry-pi-motd/install-motd/install-motd && sudo chmod +x /home/pi/raspberry-pi-motd/install-motd/install-motd
sudo sh /home/pi/raspberry-pi-motd/install-motd/install-motd
cd /raspberry-pi-motd/install-motd
sudo sh install-motd
sudo echo "/etc/motd.sh" >> ~/.profile
rm -R /home/pi/raspberry-pi-motd
```


