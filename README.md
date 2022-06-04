# DEEPLAY TEST TASK

## 1. Script to find `sid`

* Script find log notation by specified IP adress and print `sid` from it.
* Script `sid_finder.sh` with log file `log.txt` located at `script` directory.
* To run, the script requires two arguments:
    * path to log file what need to be searched
    * ip address of log notation where "sid" need to be found  

> USAGE EXAMPLE `./sid_finder.sh [PATH TO LOG FILE] [IP ADDRESS]`

## 2. Daemon systemd `hhullen` to run app as a service

* Use the `Makefile` to manage the service. Makefile has next targets:
    * <b>make install</b>. This target copies `hhullen.service` file from `src/` folder to `/etc/systemd/system/`, creates a log file `/var/log/hhullen-log.txt` and copies `app.jar` from `src/` folder to `/usr/bin/`. Also, make it enable to run with machine loading and start the `hhullen` service.
    * <b>make all</b> - is the same as `make install`.
    * <b>make uninstall</b> - stops the service and revomes aforementioned files.
    * <b>make reinstall</b> - execute `make uninstall` and then `make install`

## 3. `hhullen.service` file explanations

```
Description=Simple hhullen service
```
Simple description of the service.
```
Type=simple
```
Configures the process start-up type for this service unit. With `simple` set the unit started immediately. Chosen as commonly used to simple services.
```
ExecStart=/usr/bin/java -jar /usr/bin/app.jar /var/log/hhullen-log.txt "Service is working!"
```
Commands with their arguments that are executed when this service is started.
```
Restart=on-failure
```
Configures whether the service should be restarted when the service process exits, is killed, or a timeout is reached. Option `on-failure` means the servise will be reloaded when servise exited with non zero code, was killed or starting timeout is reached.
```
TimeoutStartSec=5
```
Configures the time to wait for start-up. Here set 5 seconds timeout to start service. If it have no been launched after this time, service will be killed.
```
TimeoutStopSec=5
```
Configures the time to wait for the service itself to stop. Here set 5 seconds timeout to start service. If it have no been launched after this time, service will be killed.
```
StartLimitIntervalSec=30
StartLimitBurst=5
```
Configure unit start rate limiting. Units which are started more than `StartLimitBurst` times within an interval time span `StartLimitIntervalSec` are not permitted to start any more.  
