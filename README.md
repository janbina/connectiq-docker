# connectiq-docker

Docker image for installation and use of Garmin's [Connect IQ SDK](https://developer.garmin.com/connect-iq/overview/).  
It is based on [kalemena/docker-connectiq](https://github.com/kalemena/docker-connectiq), but it is much simpler
because it is not downloading sdk manager or the sdk itself for you. It also does not download or set up Eclipse,
since it is not recommended and supported ide anymore.

## how to use
- run `make build` and `make run`
- download the [Connect IQ SDK manager](https://developer.garmin.com/connect-iq/sdk/) and unpack it inside created *workspace* directory
- run the sdk manager from inside the docker instance: `connectiq-sdk-manager-linux/bin/sdkmanager`
- log into the SDK manager and download devices and sdks that you need
- create your projects inside the *workspace* directory and use downloaded sdk to build them and run them on the emulator

## building and running the apps
```bash
SDK="~/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-4.0.5-2021-08-09-29788b0dc/bin"
DEVICE="venu2"

# start the emulator
$SDK/connectiq &

# build your app
$SDK/monkeyc -d $DEVICE -f ./monkey.jungle -o bin/out.prg -y ~/developer_key.der

# run app on emulator
$SDK/monkeydo bin/out.prg $DEVICE
```
