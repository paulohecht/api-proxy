# Api Proxy

A tweakable proxy to help with API testing

Features:
 - Make a request return something specific to test the app behaviour
 - Add delay to the server response to test high latency scenarios
 

![alt text](https://raw.githubusercontent.com/thehecht/api-proxy/master/screenshot.png "Screenshot")

## Installation

Install Meteor:
```
  curl https://install.meteor.com/ | sh
```

Run:
```
  meteor
```

You can configure your proxy at: http://(localhost ip):3000

Point your apps to the address at: http://(localhost ip):4000

To run the proxy in a different port:
```
  PROXY_PORT=5000 meteor
```

## TODO
- [x] Proxy
- [x] Rules
- [x] Delay
- [ ] Input validations
- [ ] Response body JSON editor
- [ ] Response headers editor
