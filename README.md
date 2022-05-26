# SENG-LIVE-060622 Phase 3

## Phase Objectives
* Understand the principles of Ruby as a language including principles of object oriented programming
* Understand the characteristics of a relational database
* Perform CRUD actions with a database using Active Record
* Design an API to handle CRUD actions
* Communicate with an API using different HTTP verbs
* Create and present a project with a React frontend and a database-backed API backend

## Lectures

1. Ruby Fundamentals ([slides](https://p3-01-ruby-fundamentals-slides.netlify.app/#/normal/0/0))
2. Object Oriented Ruby pt1 ([slides](https://p3-02-object-oriented-ruby-part1-slides.netlify.app/#/normal/0/0))
3. Object Oriented Ruby pt2 ([slides](https://p3-03-object-oriented-ruby-part-2-slides.netlify.app/#/normal/0/0))
4. Intro to Databases ([slides](https://p3-04-intro-to-databases-slides.netlify.app/#/normal/0/0))
5. Intro to ActiveRecord ([slides](https://p3-05-intro-to-databases-slides.netlify.app/#/normal/0/0))
6. ActiveRecord Associations: Many to Many ([slides](https://p3-06-activerecord-associations-many-to-many-slides.netlify.app/#/normal/0/0))
7. Debugging in Ruby (code challenge prep)
8. Intro to Sinatra (after code challenge) ([slides](https://p3-08-intro-to-sinatra-slides.netlify.app/#/normal/0/0))
9. Sinatra API CRUD with relationships

## How to use this repository

![Git Flow Diagram](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012200/GitFlow%20Images/git-flow-diagram.png)

## Day 1 Instructions

### Fork this repository

- Click on the Fork Icon at the top of the UI and wait for the forking operation to complete
- I needed to select my username here to indicate I want to fork to my account because I'm part of multiple organizations

![Forking a Repo animation](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012204/GitFlow%20Images/forking-a-repo.gif)

### Clone your fork of the repository to your local machine

To do this there are a two main tasks we'll want to complete. 

1. Get the SSH link for your fork of the repository
2. Clone the repository to a folder on your local machine

#### 1. Getting the SSH link to clone the repository

- Once the fork is complete, click on the green code button
- in the sub menu that appears, make sure that SSH is underlined
- click the clipboard button to copy the ssh link to your clipboard

![Getting the SSH clone link](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012202/GitFlow%20Images/get-ssh-clone-link.gif)

#### 2. Cloning the forked repository to a folder on your local machine
- open up a terminal and navigate to the directory where you want to store your lecture code
  - In my case I'm creating the folder through the terminal using the `mkdir lecture-code` command
  - next, `cd lecture-code` to move my terminal's working directory into the `lecture-code` folder
- run `git clone <pasteyoursshgitrepolinkhere>` in the terminal
- run `code SENG-LIVE-060622-phase-3` to open the repository within VSCode

> **PRO TIP** If you type the `tab` key on your keyboard while interacting with the terminal, you can autocomplete long file or folder names.  In this case, I typed `code SENG` and then hit the `tab` key and it expanded the path to the only folder name matching `SENG` which was `SENG-LIVE-060622-phase-3`. So, you only need to type as many characters as can uniquely identify the file or folder name that you want to open and then you can use `tab` to complete the rest of the required typing without typos!

![Cloning to your machine](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012206/GitFlow%20Images/cloning-to-your-machine.gif)

Now that you have the repository cloned to your local machine, you'll be able to following along with lecture inside of your own code editor if you wish. 

## Before Every Subsequent Lecture

1. Click on the Fetch & Merge button on your fork of the repository on GitHub.
2. Run `git pull` from within the attached terminal of your local copy of the repository in VS Code. 

![Fetch and Merge Into Git Pull](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012208/GitFlow%20Images/fetch-and-merge-into-git-pull.gif)

## Recommended VS Code Extension for Git

GitLens! See the GIF below for an example of how to install a VSCode extension.

![Installing GitLens](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012204/GitFlow%20Images/installing-gitlens.gif)

The GitLens extension allows you an integrated Visual interface for viewing past commits, stashes and even file history over time. It adds options directly into the built in Version Control pane of the VSCode editor.
## Merge Conflicts

If all goes well, you should not encounter merge conflicts when you follow this workflow as part of participation in lecture. There is one scenario where they might come up, so I want to describe it here and how to address it.

### Scenario

Say these events happen in this order:

1. Your lecturer sends out a message in Slack notifying the class that starter code is ready to fetch and merge before lecture. 
2. You go through the steps above and pull down the updated code to your machine. 
3. You start taking some notes there and attempting to solve problems in the starter code.
4. The lecturer notices something in the lecture code that they want to change and pushes another commit to the lecture repo.

In this case, going through the `fetch & merge` and `git pull` workflow may result in what's called a merge conflict. The safest thing to do in this situation is to run `git stash` locally to hide your changes in your local repository so that the `pull` from GitHub goes off without a hitch. You can still view the code within your stash within VSCode and you can even return it to your machine with `git stash pop` if you like.

![Using Git Stash](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012206/GitFlow%20Images/using-git-stash.gif)

If this scenario arises, your lecturer will generally communicate the change in advance, so this scenario should be rare. But, should it happen, this is one approach you can take to get around any potential problems.

If you have code stashed in your local repository, it won't be visible within the regular file structure (AKA your working directory). If you want to return the code to your machine, you can still do so by applying the stash.

![Applying a Stash](https://res.cloudinary.com/dnocv6uwb/image/upload/v1649012203/GitFlow%20Images/applying-stash-to-add-change-back-to-folder.gif)

If you prefer, you can simply keep your code in the stash and it'll allow you to more clearly see the difference between your code and the starter code when you click on a stashed change within the Version Control Tab's Stashes dropdown. It will show you a visual diff with your additions highlighted in green and your removals highlighted in red.

## Git Resources 

- <a href="https://gitimmersion.com/index.html" target="_blank">Git Immersion (hands on practice with git exercises on a simple ruby project)</a>
- <a href="http://git-scm.com/book" target="_blank">Pro Git (online Book for reference)</a>
- <a href="http://www-cs-students.stanford.edu/~blynn/gitmagic/pr01.html" target="_blank">Git Magic</a>
