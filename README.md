# Splunk Notes

## Introduction
This repo contains notes and useful commands that I have found while depoloying and administering Splunk. I will also add any script that may help in automating the splunk installs.

You check out my other repos for more Splunk configurations.

## Contents

1. [Useful Documentation](#1---useful-documentation)
2. [Initial Setup Commands](#2---initial-setup-commands)
3. [Useful Commands](#3---useful-commands)
4. [Scripts](#4---scripts)
	1. [Splunk Enterprise Initial Setup](#1-splunk-enterprise-initial-setup)
	2. [Splunk Universal Forwarder Guided Install](#2-splunk-universal-forwarder-guided-install)
5. [Splunk Apps](#5---splunk-apps)
	1. [VirusTotal Command App](#1-virustotal-command-app)
	2. [Sysinternal Autoruns Input App](#2-sysinternal-autoruns-input-app)

## 1 - Useful Documentation

#### Splunk Documentation
* [Splunk Docs](http://docs.splunk.com/Documentation)
  * [Inputs.conf](http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Inputsconf)
  * [Outputs.conf](http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Outputsconf)
  * [Props.conf](http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Propsconf)
  * [Transforms.conf](http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Transformsconf)
  * [Indexes.conf](http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Indexesconf)
  * [Deploymentclient.conf](http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Deploymentclientconf)
  
#### SPLUNK APPS
* [Splunkbase](https://splunkbase.splunk.com/)
  
#### SPLUNK EDUCATION
* [Splunk Training](https://www.splunk.com/en_us/view/education/SP-CAAAAH9)
  
#### OTHER SPLUNK RESOURCES
* [Splunk Wiki](https://wiki.splunk.com/Main_Page)
  * [Where do I configure my Splunk Settings](https://wiki.splunk.com/Where_do_I_configure_my_Splunk_settings%3F)

## 2 - Initial Setup Commands

**Splunk Enterprise Download**
```bash
wget -O /tmp/splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=splunk&filename=splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz&wget=true'
```

**Splunk Universal Forwarder Download**
```bash
wget -O /tmp/splunkforwarder-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=universalforwarder&filename=splunkforwarder-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz&wget=true'
```

**Create user splunk**
```bash
sudo useradd splunk
```

**Add to splunk user ~/.bash_profile**
```bash
export SPLUNK_HOME=/opt/splunk
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$SPLUNK_HOME/bin
```

**Install Splunk**
```bash
sudo tar xvzf /tmp/splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz -C /opt
sudo chown -R splunk:splunk /opt/splunk/
sudo -u splunk /opt/splunk/bin/splunk start --accept-license
#AS SPLUNK USER
splunk edit user admin -password <NEW PASSWORD> -role admin -auth admin:changeme
sudo /opt/splunk/bin/splunk enable boot-start -user splunk
```

**Splunk Universal Forwarder**
```bash
sudo /opt/splunkforwarder/bin/splunk enable boot-start -user splunk
```
## 3 - Useful Commands

**ANY SPLUNK CONFIGURATION**

```
splunk btool <props, transforms, inputs, limits> list <name of monitor, sourcetype, or leave blank> --debug |grep -v system/default
splunk btool <props, transforms, inputs, limits> list --debug |grep -v system/default |grep <information about what you are looking for>
splunk btool props list <sourcetype> --debug |grep -v system/default
splunk btool transforms list <transform stanza> --debug |grep -v system/default
```
**CLIENTS**

Who is my deployment server
```
splunk list deploy-poll
```
**DEPLOYMENT SERVER**

Makes changes available to deployment clients
```
splunk reload deploy-server
splunk reload deploy-server -class <serverclass>
```
**INDEXERS**

Push apps from Master-Apps to Splave-Apps on Indexers
```
splunk apply cluster-bundle
```
Show status of cluster app deployments
```
splunk show cluster-bundle-status
```
Show Index cluster status
```
splunk show cluster-status
```
Takes splunk offline (default 1 min)
```
splunk offline
```
Change offline time (reset to 1 min when done)
```
splunk edit cluster-config -restart_timeout <SECONDS>
```
Oneshot log ingestion
```
splunk add oneshot -index <index name> -source <log file path> -sourcetype <log sourcetype>
```

## 4 - Scripts

##### 1. [Splunk Enterprise Initial Setup](./install_splunkenterprise.sh)
** Note: This works on CentOS 7. May require a few tweeks in RHEL 7 regarding the THP

This is a shell script that when run as root will configure the OS by disabling transparent huge pages (THP), and set ulimits to recommended values, download the latest (as of 2/5/2018) version of Splunk Enterprise, and install it.

##### 2. [Splunk Universal Forwarder Guided Install](./splunk_guided_install.ps1)

This is a guided install written in Powershell. You can use it to search Active Directory for machine names, specify an input file
with a list of machine names, or you can run it as a local install.

You will also have the ability to specify a deployment server as well as an install location. 

## 5 - Splunk Apps

This is a list of apps that I am working on right now. I will be putting together more details on each project shortly.

##### 1. [VirusTotal Command App](https://github.com/badgerttl/vtlu_command)

##### 2. [Sysinternal Autoruns Input App](https://github.com/badgerttl/autoruns_input)
