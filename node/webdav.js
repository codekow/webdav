// imports
//import { v2 as webdav } from 'webdav-server'
const webdav = require('webdav-server').v2;

// User manager (setup coder based on ENV PASSWORD)
const userManager = new webdav.SimpleUserManager();

// setup the defaults for webdav from env variables
const username = process.env.WEBDAV_USER || 'coder';
const password = process.env.WEBDAV_PASS;
const shareFolder = process.env.WEBDAV_PATH || '/home/coder';
const webdavPort = process.env.WEBDAV_PORT || 8000;

const user = userManager.addUser(username, password, false);

// Privilege manager (tells which users can access which files/folders)
const privilegeManager = new webdav.SimplePathPrivilegeManager();
privilegeManager.setRights(user, '/', [ 'all' ]);

const server = new webdav.WebDAVServer({
// HTTP Digest authentication with the realm 'Default realm'
  httpAuthentication: new webdav.HTTPDigestAuthentication(userManager, 'Default realm'),
  privilegeManager: privilegeManager,
  port: webdavPort
});

server.afterRequest((arg, next) => {
  // Display the method, the URI, the returned status code and the returned message
  console.log('>>', arg.request.method, arg.requested.uri, '>', arg.response.statusCode, arg.response.statusMessage);
  next();
});

server.setFileSystem('/', new webdav.PhysicalFileSystem(shareFolder), (success) => {
  server.start(() => console.log('WebDav Server - READY'));
})