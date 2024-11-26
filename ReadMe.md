# What does this container image do?

Mounts two SMB shares and replicates files using rsync every 60 seconds.

# Environment Variables

| Param |Notes|
|-------|-----|
|Azure|Set value to true if source and destination Azure Files to use for Azure Container Instance. If not set, standard SMB connections will be expected|
|SOURCEDESTINATIONSHARES|JSON Array of source and destinations coma separated. Left name is the Source SMB share name, and right name is the Destination SMB share name. Example '["source,dest","source2,dest2"]'|
|SOURCESERVER|Source SMB File Server. Not needed if Azure=true|
|SOURCEUSERNAME|Username for Source File Server. Not needed if Azure=true|
|SOURCEPASS|Password for Source File Server. Not needed if Azure=true|
|SOURCEDOMAIN|Domain of Source File Server. Not needed if Azure=true|
|DESTSERVER|Destination SMB File Server. Not needed if Azure=true|
|DESTUSERNAME|Username for Destination File Server. Not needed if Azure=true|
|DESTPASS|Password for Destination File Server. Not needed if Azure=true|
|DESTDOMAIN|Domain of Destination File Server. Not needed if Azure=true|


# How to use?

Build container image

```
docker build -t smb-sync .
```

Run Container with Env Values

```
docker run --privileged -d --name smb-sync -e SOURCESERVER=sourcefiles.file.core.windows.net -e SOURCEDESTINATIONSHARES='["ntfstesting,target","source,dest"]' -e SOURCEUSERNAME=sourcefiles -e SOURCEPASS=password -e SOURCEDOMAIN=localhost -e DESTSERVER=dstfiles.file.core.windows.net -e DESTUSERNAME=sourcefiles -e DESTPASS=password -e DESTDOMAIN=localhost smb-sync
```

--privileged is used to allow the container to connect to an external SMB file share.