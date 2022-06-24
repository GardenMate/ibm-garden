## IBM-Garden

# Build Your Garden

# Onboarding

Clone the git repo into local system
```
git init
git clone git@github.com:Abemelech/ibm-garden.git
```

Create virutual environment
```
py -m venv venv

```
Open powershell in administerative mode and run
```
set-executionpolicy RemoteSigned
```
Then go back to the git directory and cd into venv and execute
```
Scripts\activate
```
To start the venv for the backend django
To stop the virtual environment
```
deactivate
```
### To set up django
Head over to the git directory inside the activated venv and run
```
pip install django djangorestframework
```

## To commit to git
Create a new branch
```
git checkout -b <branch-name>
```
```
git add
git commit -m "<message of the commit>"
git push origin <branch-name>
```

