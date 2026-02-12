**Step 1.**  
docker pull guacamole/guacamole
docker pull guacamole/guacd
docker pull mariadb  

**Step 2.**  
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.sql  

**Step 3. Run following docker compose "docker compose up -d"**  
```
version: '3'
services:
  guacdb:
    container_name: guacamoledb
    image: mariadb
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: 'M4ri4DBR00tP4ss'
      MYSQL_DATABASE: 'guacamole_db'
      MYSQL_USER: 'guacamole_user'
      MYSQL_PASSWORD: 'M4ri4DBUs3rP4ss'
    volumes:
      - '/home/nginxproxy/guac/db:/var/lib/mysql'  
```

**Step 4.**  
docker cp initdb.sql guacamoledb:/initdb.sql  

**Step 5.**  
docker exec -it guacamoledb bash  

**Step 6. Inside container**  
cat /initdb.sql | mariadb -uroot -p guacamole_db  
exit

**Step 7.  Prepare final docker compose stack**  
```
version: '3'
services:
  guacdb:
    container_name: guacamoledb
    image: mariadb
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: 'M4ri4DBR00tP4ss'
      MYSQL_DATABASE: 'guacamole_db'
      MYSQL_USER: 'guacamole_user'
      MYSQL_PASSWORD: 'M4ri4DBUs3rP4ss'
    volumes:
      - '/home/nginxproxy/guac/db:/var/lib/mysql'
  guacd:
    container_name: guacd
    image: guacamole/guacd
    restart: unless-stopped
  guacamole:
    container_name: guacamole
    image: guacamole/guacamole
    restart: unless-stopped
    ports:
      - 8080:8080
    environment:
      GUACD_HOSTNAME: "guacd"
      MYSQL_HOSTNAME: "guacdb"
      MYSQL_DATABASE: "guacamole_db"
      MYSQL_USER: "guacamole_user"
      MYSQL_PASSWORD: "M4ri4DBUs3rP4ss"
  	  WEBAPP_CONTEXT: "ROOT"
      TOTP_ENABLED: "true"
    depends_on:
      - guacdb
      - guacd
```
