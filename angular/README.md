# Auto Angular Project Deployment

Install all required dependencies (nginx, node, npm, @angular/cli, etc.), build project, and then deploy.

## IMPORTANT NOTE: The script will run `npm run build`. so change the `scripts -> build` in `package.json`

Example:

``` json
  "scripts": {
    ...
    "build": "ng build --prod --base-href /example",
    ...
  }
```

## Directory tree for Angular project

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
