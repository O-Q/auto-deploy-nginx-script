# Auto Deploy On Nginx with Shell Script

## 1. Auto Static Files Deployment

It will install and configure all dependencies(nginx, node, etc.).
For example, built angular, react, vue, etc. project.

### Directory tree for static project

```bash
├── run-static.sh
│
├── static-nginx.conf
|
└── dist
      |
      └── <PROJECT_NAME>
              |
              └── PROJECT FILES...
```

## 2. Auto Angular Project Deployment

Install all required dependencies (nginx, node, npm, @angular/cli, etc.), build project, and then deploy.

### IMPORTANT NOTE: The script will run `npm run build`. so change the `scripts -> build` in `package.json`

Example:

``` json
  "scripts": {
    ...
    "build": "ng build --prod --base-href /example",
    ...
  }
```

### Directory tree for Angular project

``` bash
├── <PROJECT_FOLDER>
│       │
│       ├── run-angular.sh
│       │
│       ├── angular-nginx.conf
│       │
│       └── PROJECT FILES...
│
```

## 3. Auto SSL Certificate

It will install and configure all!
Use [Let's encrypt](https://letsencrypt.org) and [Certbot](https://certbot.eff.org/) in background.
redirecting from HTTP to HTTPS will configure if you want.
