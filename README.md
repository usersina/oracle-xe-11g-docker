# Oracle with SQLDeveloper in Docker

This repository contains the following components running inside docker containers:

- [**Oracle xe 11g database**](https://www.oracle.com/technical-resources/articles/database/sql-11g-xe-quicktour.html) - ([docker image](https://hub.docker.com/r/gvenzl/oracle-xe))
- [**SQLDeveloper from Oracle**](https://www.oracle.com/database/sqldeveloper/) - ([docker image](https://hub.docker.com/r/usersina/sqldeveloper))

## Motivation

During my undergradute studies of computer science, I was required to use OracleDB for my SQL courses.
The installation process has always been a bit of a hassle, especially considering the only available free version is the [11g version](https://www.oracle.com/database/technologies/xe-downloads.html) which is quite outdated by now.

Having enrolled in an Engineering University for Computer science and not wanting to face the same experience again, I decided to run it all in docker containers and get on with life.
And potentially helping people who face the same issue in the future.

## I. Getting started

This guide was tested on Windows with git bash and on Linux runing PopOS 22.04

```bash
make start
```

And you're all good! Simply use the following credentials to connect to your oracle database from SQLDeveloper as shown in the screenshot with the password being `oracle`.

![sqldeveloper-login](./media/sqldeveloper-login.JPG)

- To stop the containers, simply do a stop

```
make stop
```

Note that this will neither delete your OracleDB data nor your SQLDeveloper pereferences.
In order to do just that, you would have to `make delete`.

## II. Extra setup

**NOTE: This is currently broken since HR does not exist and will be addressed in the future.**

You might also want to unlock the HR account to have access to the [HR (or Human Resources) schema](https://www.webucator.com/article/oracles-demo-hr-schema/) which is just a collection of useful tables often used for testing.

### 1. Unlocking HR

Enter into the running container with the system account

```bash
make shell
```

Connect with the `system` user that has the password `oracle`

```bash
sqlplus system/oracle
```

Alter the account with

```sql
ALTER USER hr ACCOUNT UNLOCK;
```

```sql
exit
```

Connect with the unlocked account

```bash
sqlplus HR/HR
```

You will be prompted to change the password, simply type `oracle` for the new password.
You can see the list of available tables with

```SQL
SELECT TABLE_NAME FROM USER_TABLES;
```

## Accounts

- Default system account

```
user: system
password: oracle
```

- HR account if you've followed the [unlocking HR step.](#1-unlocking-hr)

```
user: HR
password: oracle
```

## Troubleshooting

- **SQLDeveloper:** If you still have a "flashing screen" and the container exists, see the bottom section [docker hub link of sqldeveloper](https://hub.docker.com/r/marcelhuberfoo/sqldeveloper) to see how to solve it.
  You might also want to delete the `./tmp` directory if it was created by docker and create it yourself. To test, you can simply re-run `make start`

- **Ports are not available:** Either the port is in use or it is excluded by the system. See [this](https://github.com/docker/for-win/issues/9272#issuecomment-731847321) and [most importantly this](https://superuser.com/a/1610009/1024072) for windows.

## Roadmap

- [x] [Add persistance for the database](https://stackoverflow.com/a/65409258/10543130)
- [x] [Auto detect platform](https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script)
- [x] Expose a VNC Server instead of X11
- [ ] [Add sample data and HR table on init](https://hub.docker.com/r/gvenzl/oracle-xe)
