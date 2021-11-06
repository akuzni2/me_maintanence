# me_maintanence

Project for CS6750 Intro to Health Informatics to.

### Building And testing the Web App Locally

```
docker build -t flutterapp .
docker run -p 1200:80 flutterapp
```

### Deploying To Heroku
1) Make sure Heroku CLI is installed
2) Make sure Auth is setup and connected to me_maintanence app on Heroku
3) Make sure logged into Heroku [container registry](https://devcenter.heroku.com/articles/container-registry-and-runtime)
```
heroku container:login
```


### Other notes
AWS Signin for admin user
https://870029572904.signin.aws.amazon.com/console
USERNAME: me-maintenance-admin