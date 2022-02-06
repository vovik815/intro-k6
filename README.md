# intro-k6
Introduction to k6 load test tool


## Local test running

1. Start docker containers for [Influxdb](https://www.influxdata.com/) and [Grafana](https://grafana.com)
```sh
docker-compose up -d influxdb grafana
```
2. Start a docker container with mockserver in case it is needed.
```sh
docker-compose up -d mockserver
```
3. Configure the server with the proper expectation in the mock server, for example running an appropriate script
```sh
npm install
node mock/get-crocodiles.mock.js
```
4. Run the load test
```sh
docker-compose run --rm k6 run /scripts/load.test.js
```
5. Open the local [Grafana](http://localhost:3000) and import the dashboard using the dashboard file located in grafana/k6-load-testing-results_rev3.json

