## CGMINER docker container

Quickly and easily run CGMiner executable from within docker container.

## Usage:

Take note of all the necessary `/dev/ttyUSBXXX` names of mining devices. The script below can help locate these names (if unplugging the devices is feasible):
```bash
$ ./find_devices.sh
```
Once dev names are noted, then replace the placeholder list of devices in `docker-compose.yml` file with the proper list just found.

### Environment Variables
Make sure that either
1) the variables POOL_HOST, POOL_USER, and POOL_PASS are set
2) initialize `./.env` file [according to docker](https://docs.docker.com/compose/environment-variables/#the-env-file)

# docker-compose up
Finally, run the file as
```bash
$ sudo docker-compose up
```

CGMiner will start and should find all USB or serial devices.
