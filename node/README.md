## Buiding and Deploying a WebDAV Server

This project provides two templates for deploying a new WebDAV pod located in [openshift/templates/](openshift/templates/).

Both tempaltes will ask for the following paramaters:

- APPLICATION_NAME: The name that you want to call your WebDAV pod.  We recommend something like "myapp-webdav-server"
- WEBDAV_USER: The username you will be using when you mount the drive in Windows.  The default is 'coder'.
- WEBDAV_PASS: This is the password you will use with the username to mound the drive in Windows.  If you leave this field blank a random password will be generated for you.  It is highly recommended that you use a secure password.  We recommend either leaving this field blank, or generating a password.
- WEBDAV_MEM_LIMIT: This is how much memory the WebDAV pod will utilize.  WebDAV doesn't require much so feel free to leave the defaults.
- WEBDAV_CPU_LIMIT: This is how much CPU the WebDAV pod will utilize.  WebDAV doesn't require much so feel free to leave the defaults.

### Deploy with a New PVC

The [deploy-template-new-pvc.yaml](openshift/templates/deploy-template-new-pvc.yaml) will generate the following objects for you:

- BuildConfig
- ImageStream
- DeploymentConfig
- Service
- Route
- PVC

This template is intended to be used if you currently do not have an existing PVC you wish to share with a WebDAV container.

In addition to the paramaters mentioned above you will be asked for the following:

- VOLUME_SIZE: This will determine the size of the PVC that will be created.  You may want to adjust this depending on what you plan to store on the PVC.

### Deploy with an Existing PVC

The [deploy-template-existin-pvc.yaml](openshift/templates/deploy-template-existing-pvc.yaml) template will generate the following objects for you:

- BuildConfig
- ImageStream
- DeploymentConfig
- Service
- Route

This tempalte is intended to be used if you already have an existing PVC that you would like to enable access to with WebDAV.  In order for multiple Pods to access the same PVC, the PVC must utilize ReadWriteMany mode.

In addition to the paramaters mentioned above you will be asked for the following:

- PVC_NAME: This is the name of the PVC you wish to add to WebDAV to.  This must exactly match the name of the PVC.

## Access your WebDAV Server

### Required Information

In order to mount the PVC as a drive in Windows you will need to know the following information:

- Username: The default is 'coder'
- Password: The default is generated for you
- Route: This is a URL that is generated for you

The username and password can be found in the Environment Variables for either your running Pod or the Deployment Config in the OpenShift Console.

The Route can be found in the Routes section of the OpenShift Console.