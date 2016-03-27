**Application**

[TeamSpeak3](https://www.teamspeak.com/)

**Description**

TeamSpeak is a proprietary voice-over-Internet Protocol (VoIP) software that allows computer users to speak on a chat channel with fellow computer users, much like a telephone conference call. A TeamSpeak user will often wear a headset with an integrated microphone. Users use the TeamSpeak client software to connect to a TeamSpeak server of their choice, from there they can join chat channels and discuss things.

**Build notes**

Latest stable TeamSpeak release, using the AUR package "teamspeak3-server".

**Usage**
```
docker run -d \
    --net="host" \
    --rm=true \
    --name=<container name> \
    -v <path for config files>:/teamspeak/data \
    -v <path for logs>:/teamspeak/logs \
    -v /etc/localtime:/etc/localtime:ro \
    -e TS_UID=<uid for teamspeak user> \
    -e TS_GID=<gid for teamspeak user> \
    djmattyg007/arch-teamspeak
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

Connect using the TeamSpeak client on `<host ip>:9987`

**Example**
```
docker run -d \
    --net="host" \
    --rm=true \
    --name=teamspeak \
    -v /apps/docker/teamspeak/data:/teamspeak/data \
    -v /apps/docker/teamspeak/logs:/teamspeak/logs \
    -v /etc/localtime:/etc/localtime:ro \
    -e TS_UID=997 \
    -e TS_GID=998 \
    djmattyg007/arch-teamspeak
```

**Notes**

This is a fork of binhex/arch-teamspeak that uses djmattyg007/arch-base and does not install an AUR helper.

User ID (TS\_UID) and Group ID (TS\_GID) can be found by issuing the following command for the user you want to run the container as:

```
id <username>
```

To authenticate use the privileged key shown in /teamspeak/data/ts3-stderr.log
