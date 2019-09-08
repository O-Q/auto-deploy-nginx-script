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
    && echo_bold "Install SSL Certificate on Nginx Script!" \
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
    && install_dep "software-properties-common" \
    && install_dep "certbot" \
    && install_dep "python-certbot-nginx" \
    && echo \
    && echo_bold "All Dependencies installed Successfully!" \
    && echo_line \
    && echo
}
install_cert() {
    echo_bold "Installing SSL Certifacte..." \
    && echo \
    && echo "Enter your email: " \
    && read EMAIL \
    && echo "Enter your domain(s): (separate with comma)" \
    && read DOMAINS \
    && sudo certbot --nginx --non-interactive --agree-tos --email $EMAIL --domains $DOMAINS \
    && echo_bold "SSL Certifacte installed Successfully!" \
    && echo_line \
    && echo
}



config_ufw() {
    echo_bold "Configuring ufw..." \
    && echo \
    && sudo yes | sudo ufw enable \
    && sudo yes | sudo ufw allow 22 \
    && sudo yes | sudo ufw allow 'Nginx HTTPS' \
    && sudo yes | sudo ufw status \
    && echo_bold "ufw Configuration done Successfully!" \
    && echo_line \
    && echo
}

redirection() {
    echo_bold "redirect HTTP to HTTPS?: (y/n)" \
    && read ANS \
    && if [ $ANS = "y" ] 
    then
        FILE=$(find /etc/nginx/sites-enabled/*-nginx.conf) \
        && LINE=$(grep --regex='server_name [a-zA-Z]' *-nginx.conf) \
        && sudo sed -i 's+server_name _;+'"$LINE"';\n\treturn 301 https://$server_name$request_uri;+g' $FILE
    fi
}

nginx_restart() {
    echo_bold "Restarting Nginx..." \
    && echo \
    && systemctl restart nginx \
    && echo_line \
    && echo
}

echo_title \
&& sudo yes | sudo add-apt-repository ppa:certbot/certbot \
&& sudo yes | sudo apt update \
&& install_deps \
&& install_cert \
&& config_ufw \
&& redirection \
&& nginx_restart \
&& echo \
&& echo_bold "Finished Successfully!" \
