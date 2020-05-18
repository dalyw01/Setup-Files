# Git and Github

Download from homebrew - brew install git

Setup SSH key here to link your machine and your account - https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

To be able to push via HTTPS - https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line

Here is a list of quick commands to do most typical tasks

![Git](https://dl2.macupdate.com/images/icons256/39062.png?d=1558008000)

## Creating repo from local files and pushing to GitHub

FIRST create the repo on github e.g - https://github.com/dalyw01/my_new_repo

```
git init
git add .
git commit -m "first commit"
git remote add origin https://github.com/dalyw01/my_new_repo.git
git push -u origin master
```

## Setting up new branch and commiting to it

FIRST have the link to the repo you want to clone handy e.g - https://github.com/dalyw01/smp-ui-tests.git

```
mkdir x
cd x
git init
git clone https://github.com/dalyw01/smp-ui-tests
git remote add origin https://github.com/dalyw01/smp-ui-tests.git
git add .
git commit -m "asdadads" (This is to generate a master branch)
git branch wills_branch 
git checkout wills_branch    
git push -u origin wills_branch
```
## Downloading specific branch of a repo

Make a folder and enter it

```
git clone -b NihalBranch git@github.com:dalyw01/Test-Combos-For-Web.git
```

Verify on branch

```
git branch
* NihalBranch
```

## Setting a new remote after breaking previous

```
git remote set-url origin https://github.com/dalyw01/Scanner.git
git pull origin master
```
