# splunk_notes

<h3>INTRODUCTION</h3>
<p>This repo contains notes and useful commands that I have found while depoloying and administering Splunk. I will also add any script that may help in automating the splunk installs.</p>
<p>You check out my other repos for more Splunk configurations.</p>

<div id="toc_container">
	<p class="toc_title"><h3>Contents</h3></p>
<ul class="toc_list">
  <li><a href="#1---useful-documentation">1 - Useful Documentation</a>
  <li><a href="#2---initial-setup-commands">2 - Initial Setup Commands</a>
</ul>
</div>

<h2>1 - Useful Documentation</h2></a>

<h4>SPLUNK DOCUMENTATION</h4>
	<ul>
		<li><a href="http://docs.splunk.com/Documentation">Splunk Docs</a></li>
			<ul>
					<li><a href="http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Inputsconf">Inputs.conf</a></li>
					<li><a href="http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Outputsconf">Outputs.conf</a></li>
					<li><a href="http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Propsconf">Props.conf</a></li>
					<li><a href="http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Transformsconf">Transforms.conf</a></li>
					<li><a href="http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Indexesconf">Indexes.conf</a></li>
					<li><a href="http://docs.splunk.com/Documentation/Splunk/7.0.2/admin/Deploymentclientconf">Deploymentclient.conf</a></li>
				</ul>
		</ul>

<h4>SPLUNK APPS</h4>
<ul>
	<li><a href="https://splunkbase.splunk.com/">Splunkbase</a></li>
</ul>
  
<h4>SPLUNK EDUCATION</h4>
<ul>
 <li><a href="https://www.splunk.com/en_us/view/education/SP-CAAAAH9">Splunk Training</a></li>
</ul>
  
<h4>OTHER SPLUNK RESOURCES</h4>
<ul>
	<li><a href="https://wiki.splunk.com/Main_Page">Splunk Wiki</a></li>
		<ul>
				<li><a href="https://wiki.splunk.com/Where_do_I_configure_my_Splunk_settings%3F">Where do I configure my Splunk Settings</a></li>
		</ul>
</ul>


<h2>2 - Initial Setup Commands</h2></a>

<p><b>Splunk Enterprise Download</b></br>
<pre>wget -O /tmp/splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=splunk&filename=splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz&wget=true'</pre></br></p>

<p><b>Splunk Universal Forwarder Download</b></br>
<pre>wget -O /tmp/splunkforwarder-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=universalforwarder&filename=splunkforwarder-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz&wget=true'</pre></br></p>

<p><b>Create user splunk</b></br>
<pre>sudo useradd splunk</pre></br></p>
<p><b>Add to splunk user ~/.bash_profile</b></br>
<pre>export SPLUNK_HOME=/opt/splunk
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$SPLUNK_HOME/bin</pre></br></p>

<p><b>Install Splunk</b></br></p>
<pre>sudo tar xvzf /tmp/splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz -C /opt
sudo chown -R splunk:splunk /opt/splunk/
sudo -u splunk /opt/splunk/bin/splunk start --accept-license
#As splunk user
splunk edit user admin -password &ltNEW PASSWORD&gt -role admin -auth admin:changeme
sudo /opt/splunk/bin/splunk enable boot-start -user splunk</pre></br></p>

<p><b>Splunk Universal Forwarder</b></br>
<pre>sudo /opt/splunkforwarder/bin/splunk enable boot-start -user splunk</pre></br></p>
