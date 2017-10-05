# REISystems-OGPS-NYC-deploy

## Development with [Docker for Mac](https://www.docker.com/products/docker)
- Prepare the code
    - `git clone git@github.com:NYCComptroller/Checkbook.git`
    
    - `wget http://code.highcharts.com/zips/Highcharts-4.0.4.zip && unzip Highcharts-4.0.4.zip -d Checkbook/source/webapp/sites/all/modules/custom/widget_framework/widget_highcharts/highcharts/4.0.4 && rm Highcharts-4.0.4.zip`
    
    - `wget http://code.highcharts.com/zips/Highstock-1.2.4.zip && unzip Highstock-1.2.4.zip -d Checkbook/source/webapp/sites/all/modules/custom/widget_framework/widget_highcharts/highstock/4.0.4 && rm Highstock-1.2.4.zip`
    
    - `cp settings.php Checkbook/source/webapp/sites/default/`
    
- Set up Docker containers
    
    - `cp ~/.ssh/id_rsa.pub authorized_keys`
    
    - `docker build -t checkbook .`
    
    - `docker-compose up -d`
    
- Deploy latest DB
    
    - get dev sql using jenkins or ask devs
    
    - `mysql -h 127.0.0.1 -P 3373 -u checkbook -psuperpassword checkbook < checkbook_drupal*.sql`
    
    - to test your machine try `ssh ubuntu@localhost -p 2232`
    
- Deploy the app
    
    - `(cd ansible && ansible-playbook checkbook-web.yml)`
     
- Open http://checkbook:8808/

- To log in admin panel, go to http://checkbook:8808/user/login and try `admin`:`admin`

All the modifications you do within Checkbook folder are applied immediately to Docker container app.

## Other

- To update ansible vendor dependencies:

    - `(cd ansible/roles/vendor && ansible-galaxy install -r requirements.yml)`

- To start/stop docker containers (note that containers will be started automatically after your machine reboot):

    - `docker stop checkbook_web checkbook_db`
    
    - `docker start checkbook_web checkbook_db`
    
- Connect to container (you should not need it most of the time)

    - `docker exec -it datagov_wp_web /bin/bash`

- You can also try php5 stack

    - `docker build -t checkbook-php5 . -f Dockerfile.php5`