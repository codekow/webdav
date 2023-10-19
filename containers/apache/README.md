## Buiding and Deploying a WebDAV Server

In order to build and deploy your own WebDAV server you will need to first configure the build process, and you can then utilize the provided templates to deploy a running instance of WebDAV.

All of the files used for building and deploying this project can be found in the [openshift](openshift/) folder.


## How to Build the Image

The files for Building the image can be found in [openshift/build](openshift/build).

This build contains a buildConfig file that will define how an image will be build and an ImageStream file that will create a location for the built image to be saved.

From the OpenShift console, use the `Import YAML/JSON` option and copy and paste the contents of the two files into your OpenShift project.

Alternatively, you can use the `oc apply -f` command and provide the path to the YAML files if you have cloned this repo to a location with the `oc` utility installed.

## How to Deploy a Pod

This project provides two templates for deploying a new WebDAV pod.

Both tempaltes will ask for the following paramaters:

- APPLICATION_NAME: The name that you want to call your WebDAV pod.  We recommend something like "myapp-webdav-server"
- WEBDAV_USER: The username you will be using when you mount the drive in Windows.  The default is 'coder'.
- WEBDAV_PASS: This is the password you will use with the username to mound the drive in Windows.  If you leave this field blank a random password will be generated for you.  It is highly recommended that you use a secure password.  We recommend either leaving this field blank, or generating a password.
- WEBDAV_MEM_LIMIT: This is how much memory the WebDAV pod will utilize.  WebDAV doesn't require much so feel free to leave the defaults.
- WEBDAV_CPU_LIMIT: This is how much CPU the WebDAV pod will utilize.  WebDAV doesn't require much so feel free to leave the defaults.

### Deploy with a New PVC

The [deploy-template-new-pvc.yaml](openshift/templates/deploy-template-new-pvc.yaml) will generate the following objects for you:

- DeploymentConfig
- Service
- Route
- PVC

This template is intended to be used if you currently do not have an existing PVC you wish to share with a WebDAV container.

In addition to the paramaters mentioned above you will be asked for the following:

- VOLUME_SIZE: This will determine the size of the PVC that will be created.  You may want to adjust this depending on what you plan to store on the PVC.

### Deploy with an Existing PVC

The [deploy-template-existing-pvc.yaml](openshift/templates/deploy-template-existing-pvc.yaml) template will generate the following objects for you:

- DeploymentConfig
- Service
- Route

This tempalte is intended to be used if you already have an existing PVC that you would like to enable access to with WebDAV.

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