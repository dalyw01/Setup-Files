Go to Oracle install java 11 - https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html

Go here - https://jenkins.io/doc/pipeline/tour/getting-started/

Run command - java -jar jenkins.war --httpPort=8083

If fails then try different port - java -jar jenkins.war --httpPort=8083

Open in browser - http://localhost:8083/login?from=%2F

Navigate to directory in terminal to get initialAdminPassword and "open open initialAdminPassword"

Install suggested plugins

If Jenkins Home Page is BLANK then just restart it - java -jar jenkins.war --httpPort=8083

Copy into the same directory as the .war and name JenkinsFile

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

In Jenkins make click New Item

Select "Freestyle project"

Add the url for "GitHub Project" - https://github.com/dalyw01/smp-tests/

Tick on "Git" and add to the "Repository URL" - https://github.com/dalyw01/smp-tests/

Under "Build" add "Execute Shell" and the steps

bundle install

brew install selenium-server-standalone

brew cask install chromedriver

rvm install 2.5.3

rvm list

rvm use 2.5.3

cucumber features/core_features/core_functionality.feature:45
