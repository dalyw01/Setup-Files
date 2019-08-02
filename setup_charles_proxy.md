# Setup Charles on a Mac

On your Mac do the following...

- Location OFF
- ETHERNET cable in (dirty, non corporate connection)
- Verify you have internet connectivity in your browser
- Network share ON (Share from an ETHERNET connection to WIFI)
- Start running Charles
- From here we will connect an iOS device and Android device observing their network traffic

## Connect iOS device to Mac so CHARLES can see traffic

- Go to SETTINGS on iOS device
- Find the wi-fi name of your Mac (but don't connect to it yet)
- Press i on the wi-fi name of your Mac
- Under HTTP Proxy press "Configure Proxy"
- Select Manual
```
- Server =  On your Mac...[Apple Logo] -> [System Preferences] -> Network (e.g 192.168.3.121 USUALLY)
- Port   = 8888
```
- Authentication OFF
- Press Save
- Press "Join This Network"
- A pop-up in Charles should appear to allow or deny the connection device


##Connect Android device to Mac so CHARLES can see traffic

- Go to SETTINGS
- Tap + Hold that network name
- Tap "Connect to Network"
- Tap Modify Network
- Tap Advanced Options
- Tap Proxy Manual
```
- Server = [Apple Logo] -> [System Preferences] -> Network (e.g 192.168.3.121 USUALLY)
- Port   = 8888
```
- Connect to the PC you’ve configured

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

