# REISystems-OGPS-NYC-deploy

[![CircleCI](https://circleci.com/gh/REI-Systems/REISystems-OGPS-NYC-deploy.svg?style=svg)](https://circleci.com/gh/REI-Systems/REISystems-OGPS-NYC-deploy)

## Development with [Docker for Mac](https://www.docker.com/products/docker)
- Get [Docker for Mac](https://www.docker.com/products/docker)

- Clone this repo
    - `git clone git@github.com:REI-Systems/REISystems-OGPS-NYC-deploy.git checkbook && cd checkbook`

- Prepare the code
    - `git clone git@github.com:NYCComptroller/Checkbook.git Checkbook`
    
    - `wget http://code.highcharts.com/zips/Highcharts-7.1.1.zip && unzip Highcharts-7.1.1.zip -d Checkbook/source/webapp/sites/all/modules/custom/widget_framework/widget_highcharts/highcharts/7.1.1 && rm Highcharts-7.1.1.zip`
    
    - `wget http://code.highcharts.com/zips/Highstock-7.1.1.zip && unzip Highstock-7.1.1.zip -d Checkbook/source/webapp/sites/all/modules/custom/widget_framework/widget_highcharts/highstock/7.1.1 && rm Highstock-7.1.1.zip`
    
    - `cp settings.php Checkbook/source/webapp/sites/default/`
    
- Set up Docker containers
    
    - `cp ~/.ssh/id_rsa.pub authorized_keys`
    
    - `docker build -t checkbook .`
    
    - `docker-compose up -d`
    
- Deploy latest DB
    
    - get dev sql using jenkins or ask devs
    
    - `mysql -h 127.0.0.1 -P 3373 -u checkbook -psuperpassword checkbook < checkbook_drupal*.sql`
    
    - open http://localhost:8989/ if you need a `phpmyadmin`
    
- Deploy the app
    
    - `(cd ansible && ansible-playbook checkbook-web.yml)`
        - If that won't work, test your ssh connection: 
            - `ssh ubuntu@localhost -p 2232`
     
- Open http://localhost:8808/

- To log in admin panel, go to http://localhost:8808/user/login and try `admin`:`admin`

All the modifications you do within Checkbook folder are applied immediately to Docker container app.

## Other

- To get a `phpmyadmin` manually, run `docker run --name checkbook_admin -d -e PMA_HOST=docker.for.mac.localhost -e PMA_PORT=3373 -e PMA_USER=checkbook -e PMA_PASSWORD=superpassword -p 8989:80 phpmyadmin/phpmyadmin`, then open [http://localhost:8989](http://localhost:8989) in your browser

- To update ansible vendor dependencies:

    - `(cd ansible/roles/vendor && ansible-galaxy install -r requirements.yml)`

- To start/stop docker containers (note that containers will be started automatically after your machine reboot):

    - `docker stop checkbook_web checkbook_db`
    
    - `docker start checkbook_web checkbook_db`
    
- Connect to container (you should not need it most of the time)

    - `docker exec -it datagov_wp_web /bin/bash`

- You can also try php5 stack

    - `docker build -t checkbook-php5 . -f Dockerfile.php5`
