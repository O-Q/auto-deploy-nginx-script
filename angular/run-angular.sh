#! /bin/sh

bold=$(tput bold)
normal=$(tput sgr0)

echo_bold() {
    TEXT=$1
    echo "${bold}$TEXT${normal}"
}
echo_line(){
    echo "-----------------------------------"
}
echo_title() {   
    echo_line \
    && echo_bold "Deploy Angular on Nginx Script!" \
    && echo "Author: @MiakovA" \
    && echo "Version: 0.1" \
    && echo_line \
    && echo
}
install_dep() {
    APP_NAME=$1
    RESULT=$(sudo dpkg -l | grep "ii  $APP_NAME " -c)
    if test $RESULT -ge 1; then
        echo "$(echo_bold $APP_NAME) is installed."
    else
        sudo yes | sudo apt install $APP_NAME &&
            echo "$(echo_bold $APP_NAME) is installed."
    fi
}

install_deps() {
    echo_bold "Installing Dependencies..." \
    && echo \
    && install_dep "nodejs" \
    && install_dep "nginx" \
    && install_dep "npm" \
    && echo \
    && echo_bold "All Dependencies installed Successfully!" \
    && echo_line \
    && echo
}

install_npm_dep() {
    APP_NAME=$1
    sudo yes | sudo npm install -g $APP_NAME &&
    echo "$(echo_bold $APP_NAME) is installed."
}

install_npm_deps() {
    echo_bold "Installing npm Dependencies..." \
    && echo \
    && install_npm_dep "npm@latest" \
    && install_npm_dep "@angular/cli" \
    && echo \
    && echo_bold "All npm Dependencies installed Successfully!" \
    && echo_line \
    && echo
}

install_project_deps() {
    echo_bold "Installing Project Dependencies..." \
    && echo \
    && sudo npm install \
    && echo \
    && echo_bold "All Project Dependencies installed Successfully!" \
    && echo_line \
    && echo
}

build_project() {
    echo_bold "Building Project..." \
    && echo \
    && sudo npm run build \
    && echo \
    && echo_bold "Building Project finished Successfully!" \
    && echo_line \
    && echo
}

config_ufw() {
    echo_bold "Configuring ufw..." \
    && echo \
    && sudo yes | sudo ufw enable \
    && sudo yes | sudo ufw allow 22 \
    && sudo yes | sudo ufw allow 'Nginx HTTP' \
    && sudo ufw status \
    && echo_bold "ufw Configuration done Successfully!" \
    && echo_line \
    && echo
}
copy_angular_dist() {
    echo "Enter project folder name(example: my-first-project):"
    read PROJECT_NAME
    echo_bold "Copying dist files to '/var/www/angualr-deploy'..." \
    && sudo rm -rf /var/www/angular-deploy \
    && sudo mkdir /var/www/angular-deploy \
    && sudo cp dist/$PROJECT_NAME/* /var/www/angular-deploy/ \
    && echo_bold "Files copied Successfully!" \
    && echo_line \
    && echo
}

config_nginx(){
    echo_bold "Configuring Nginx..." \
    && echo \
    && sudo sed -i 's+sites-enabled/\*+sites-enabled/\*.conf+g' /etc/nginx/nginx.conf \
    && sudo cp angular-nginx.conf /etc/nginx/sites-enabled/ \
    && echo "Nginx restarting..." \
    && sudo systemctl restart nginx \
    && echo_bold "Nginx Configuration done Successfully!" \
    && echo_line \
    && echo
}

nginx_status() {
    echo_bold "Nginx Status..." \
    && echo \
    && systemctl status nginx \
    && echo_line \
    && echo
}

echo_title \
&& sudo yes | sudo apt update \
&& install_deps \
&& install_npm_deps \
&& install_project_deps \
&& build_project \
&& config_ufw \
&& copy_angular_dist \
&& config_nginx \
&& nginx_status \


# in package.json --prod
