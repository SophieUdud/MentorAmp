# MentorAmp
Adrien's branch named Adrien
The intent behind this document is to give general guidelines to github contributors, reviewers and approvers of this repository. The ‘master’ branch will be blocked by default, you need two code reviewers to approve your code before you can merge pull requests into ‘master’ branch.

# Code Contributors

The ‘master’ branch will be blocked by default. So as a contributor when you are working on a given Asana task, create a new branch and then work on changes in that branch.

So an example flow can look like the following: 

* Working on an Asana task named ‘Watch Star Wars’
* Create a branch named ‘starwars’
  Commands can look like the following:
  First, check that you are on latest master and update to latest just in case:
     * git checkout master
     * git pull origin master
* Now create a new branch
     * git checkout -b starwars
* Work on your changes in that branch
* Remember to periodically commit to your local branch
* First, stage your changes to be committed
    * git status
      This will list the files to which you have made changes locally
* To add the files that you want to stage for commit:
    * git add <filename>  
  Or, to stage all the files listed:
    * git add . 
* Check that the correct files are staged
    * git status
* Commit your changes
    * git commit -m (Give meaningful description of your changes)
* The above changes at this point are just in your computer
  You can even push your changes to the remote branch
    * git push origin starwars
* Now your changes are in the cloud (you can see it on github.com)
* Once the work and changes for your task are done you can create a pull request. Please add all the devs as reviewers.
  Below doc describes how to create a pull request
  https://gist.github.com/vlandham/3b2b79c40bc7353ae95a
      
Please always remember to follow code style guidelines below and always add some tests for code that you have written.

# Code Reviewers

As a code reviewer you are buddy to your contributor, so please always keep that in mind.

Below are high level guidelines for reviewers.

* Does code follow style guidelines mentioned in the below section?
* Find bugs in their code, by really understanding and following the logic in the code.
  Tip: Do line-by-line code review; understand the intent behind that line
* Does the code review request have tests? 
  If ‘yes’, review the test code also line by line. 
  If ‘no’, you can ask them to add tests.
* If you are confused while reading the code, you can always ask clarifying questions or ask them to make changes so the code is more clear.
* Approve code only when above guidelines are met and all of your open comments are closed.

# Code Style Guidelines

This is common practice in most companies in Silicon Valley. A general coding style and conventions are described in this doc.
Contributors should keep this in mind while writing code and as a reviewer, please catch any irregularity during the code review process.
https://docs.google.com/document/d/15AbXqwsgDtTIKEa_hftAKMAUeYHt3RXaTPijPtsMuqs
