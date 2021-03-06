# Setup Charles on a Mac

On your Mac do the following...

- Location OFF
- ETHERNET cable in (dirty, non corporate connection)
- Verify you have internet connectivity on your browser
- Network share ON (Share from an ETHERNET connection to WIFI)
- Start running Charles
- From here we will connect an iOS device and Android device observing their network traffic

Make a note of your IP address of your machine, it is located at -
```
Apple Logo -> System Preferences -> Network
```
It should look something like 
```
192.168.3.121
```

## Connecting an iOS device to Mac so CHARLES can see traffic

- Go to SETTINGS on iOS device
- Go to WIFI
- See listed WIFI networks
- Find the WIFI name of your Mac (but don't connect to it yet)
- Tap (i) of your Macs WIFI
- Under HTTP Proxy tap "Configure Proxy"
- Select Manual
- Enter into "Server" and "Port" the following
```
Server = 192.168.3.121 (This should be YOUR IP address)
Port   = 8888
```
- Authentication OFF
- Tap Save
- Tap "Join This Network"
- A pop-up in Charles should appear to allow or deny the connection device

## Connect Android device to Mac so CHARLES can see traffic

- Go to SETTINGS
- Go to WIFI
- See listed WIFI networks
- Connect to WIFI of your machine
- Tap + Hold the network name of your machines WIFI
- Tap "Modify network settings"
- Tap Advanced 
- Set Proxy to "Manual"
- Enterinto "Proxy host name" and "Proxy port" the following
```
Proxy host name = 192.168.3.121 (This should be YOUR IP address)
Proxy port = 8888
```
- Connect to the WIFI of your machine you just configured
- A pop-up in Charles should appear to allow or deny the connection device

+++++++++++++++++
HTTPS working iOS
+++++++++++++++++
+ Get device (used iOS11)
+ Connect to your laptop
+ Use SAFARI
+ Download file - NAMEXYZ.mobileconfig
+ Install profile
+ Press Done
+ Turn on SSL trust for that certificate - 
+ Settings > General > About > Certificate Trust Settings. 
+ Under "Enable full trust for root certificates," turn on trust for the certificate.

++++++++++++++++++++++++++
HTTPS working with Android
++++++++++++++++++++++++++
+ Get device (SGS7 on Android 8)
+ Download onto the device - NAMEXYZW.cert.pem
+ Name the file whatever
+ You maye be ptomped to setup a lock-screen
+ Go to - Security Settings -> View Security Certificates -> User
+ The cert you named should be under the "User" section

