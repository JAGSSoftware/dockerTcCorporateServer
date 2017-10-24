The `Dockerfile` has been configured to create a `Docker image` **after**
the installation of a `Teamcenter Corporate Server` in the system. Therefore
the file is not universal.

`Teamcenter` was installed in a `CentOS 7` system in the directory `/usr/Siemens`

# Additional installations

* `jdk 8u144`
* `ksh`
* `csh`

# Environment variables

* `JAVA_HOME` = `/usr/local/oracle/jdk1.7.0u80`
* `JRE_HOME` = `$JAVA_HOME/jre`
* `TC_ROOT` = `/usr/Siemens/Teamcenter11`
* `TC_DATA` = `/usr/Siemens/tcdata`

# Notes
Once a `JAVA_HOME` or `JRE_HOME` has been set for the installation of
`Teamcenter Corporate Server`, it isn't longer refered to the environment
variable but it is using its value.
