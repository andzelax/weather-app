# you need to install to run app in express
npm init -y
# you need to install to run app in express
npm install express axios
# you need to install to run app in express
npm install dotenv


# build image
docker build -t weather-app .

# run container
docker run -p 3000:3000 --name weather-app-container weather-app

# if you want check logs via command below - run in background with -d
docker run -d -p 3000:3000 --name weather-app-container weather-app

# check logs 
docker logs -f weather-app-container

# check layers
docker history weather-app

