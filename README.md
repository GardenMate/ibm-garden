## IBM-Garden

# Build Your Garden

# Onboarding

Clone the git repo into local system
```
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
To Install necessary libraries for the framework, run these commands
```
pip install django-rest-framework
pip install django-cors-headers
pip install djangorestframework-simplejwt
pip install psycopg2
```
Set up postgres and install postgres, make sure:
username: postgres
password: postgres123

To migrate your enviornment, use this command
```
python manage.py migrate
```
To run a django server, use this command in the terminal in the directory where the django app is setup
```
python manage.py runserver
```

## To commit to git
Create a new branch
```
git checkout -b <branch-name>
```
Commit to github
```
git add
git commit -m "<message of the commit>"
git push origin <branch-name>
```

For signup and authentication
```
pip install markdown
pip install django-filter
pip install dj-rest-auth
pip install dj-rest-auth[with_social]
pip install python-decouple
```

Add a `.env` file under build_my_garden_backend and add the following:
```
EMAIL_HOST_USER = "ibm.garden@gmail.com"
EMAIL_PASSWORD = "Welcometoibmgarden123"
EMAIL_HOST_PASSWORD = "atjefnlzbkcdklep"
```

For the marketplace things to install
```
pip install django-location-field
pip install Pillow
pip install django-money
pip install geopy
``
In flutter files head to `lib/pages/sigin_page.dart` and import the following directory, vs code auto instals if you click `quick fix` and click `install dependence`
```
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
```

