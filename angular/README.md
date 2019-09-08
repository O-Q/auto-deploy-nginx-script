### AUTO Deploy Angular project on Nginx server

It will install, build and configure all!

## IMPORTANT NOTE: The script will run `npm run build`. so change the `scripts -> build` in `package.json`.

# Example:
```
  "scripts": {
    ...
    "build": "ng build --prod --base-href /example",
    ...
  }
```

## Directory tree must be like:

```

<PROJECT_FOLDER>
    |
    |_ run-angular.sh
    |
    |_ angular-nginx.conf
    |
    |_ YOUR FILES...
 
```
