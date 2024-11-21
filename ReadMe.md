# What does this container image do?

Mounts two SMB shares and replicates files using rsync every 60 seconds.

# Environment Variables

| Param |Notes|
|-------|-----|
|SOURCESERVER|Source SMB File Server|
|SOURCESHARE|Source Share Name|
|SOURCEUSERNAME|Username for Source File Server|
|SOURCEPASS|Password for Source File Server|
|SOURCEDOMAIN|Domain of Source File Server|
|DESTSERVER|Destination SMB File Server|
|DESTSHARE|Destination Share Name|
|DESTUSERNAME|Username for Destination File Server|
|DESTPASS|Password for Destination File Server|
|DESTDOMAIN|Domain of Destination File Server|


# How to use?

Build container image

```
docker build -t smb-sync .
```

Run Container with Env Values

```
docker run --privileged -d --name smb-sync -e SOURCESERVER=sourcefiles.file.core.windows.net -e SOURCESHARE=source -e SOURCEUSERNAME=sourcefiles -e SOURCEPASS=password -e SOURCEDOMAIN=localhost -e DESTSERVER=dstfiles.file.core.windows.net -e DESTSHARE=target -e DESTUSERNAME=sourcefiles -e DESTPASS=password -e DESTDOMAIN=localhost smb-sync
```

--privileged is used to allow the container to connect to an external SMB file share.