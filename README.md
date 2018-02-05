# Splunk Notes

## Introduction
This repo contains notes and useful commands that I have found while depoloying and administering Splunk. I will also add any script that may help in automating the splunk installs.

You check out my other repos for more Splunk configurations.

## Contents

1. [Useful Documentation](#1---useful-documentation)
2. [Initial Setup Commands](#2---initial-setup-commands)
3. [Scripts](#3---scripts)
	1. [Splunk Universal Forwarder Guided Install](#1-splunk-universal-forwarder-guided-install)
4. [Splunk Apps](#4---splunk-apps)
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

## 3 - Scripts

##### 1. [Splunk Universal Forwarder Guided Install](./splunk_guided_install.ps1)

This is a guided install written in Powershell. You can use it to search Active Directory for machine names, specify an input file
with a list of machine names, or you can run it as a local install.

You will also have the ability to specify a deployment server as well as an install location. 

## 4 - Splunk Apps

This is a list of apps that I am working on right now. I will be putting together more details on each project shortly.

##### 1. [VirusTotal Command App](https://github.com/badgerttl/vtlu_command)

##### 2. [Sysinternal Autoruns Input App](https://github.com/badgerttl/autoruns_input)
