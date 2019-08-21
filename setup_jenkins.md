# Setup Jenkins

![Jenkins logo](https://wiki.jenkins.io/download/attachments/2916393/logo.png?version=1&modificationDate=1302753947000&api=v2)

Jenkins is a helpful tool for automating tasks.

These tasks can vary massively in complexity. 

From building and deploying code to simply running scripts.

## Downloads

Go to Oracle and install java 11 - https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html

Go to Jenkins website and download jenkins.war - https://jenkins.io/doc/pipeline/tour/getting-started/

## Running Jenkins

Navigate to where you saved the .war and run this command to initiate Jenkins from your terminal -

```
java -jar jenkins.war --httpPort=8080
```

If that command fails then try a different port -

```
java -jar jenkins.war --httpPort=8083
```

Open in browser - http://localhost:8083/login?from=%2F

This should prompt you with a setup page

Navigate to the suggested directory in your terminal to get initialAdminPassword run

```
open initialAdminPassword"
```

Copy the password from that file and paste it in

Select **Install suggested plugins**

## Setting up for Ruby

Copy into the same directory as the .war and name JenkinsFile

```
Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { docker { image 'ruby' } }
    stages {
        stage('build') {
            steps {
                sh 'ruby --version'
            }
        }
    }
}
```

In Jenkins make click *New Item*

Select **Freestyle project**

Add the url for **GitHub Project** - https://github.com/dalyw01/smp-ui-tests/

Tick on **Git** and add to the **Repository URL** - https://github.com/dalyw01/smp-ui-tests/

Under **Build** select **Execute Shell** and the enter these steps into the field

Tick **rbenv build wrapper** and put - 2.5.3

Inside "Preinstall gem list" have - bundler,cucumber,capybara,rspec,selenium-webdriver,touch_action,image_size,chunky_png

```
bundle install

brew install selenium-server-standalone

brew cask install chromedriver

rvm install 2.5.3

rvm list

rvm use 2.5.3

cucumber features/core_features/core_functionality.feature:45
```

Save and Build

Enjoy!
