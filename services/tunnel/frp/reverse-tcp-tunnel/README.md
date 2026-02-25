Displays configuration for an frp reverse tunnel: https://gofrp.org/en/docs/
To use:

1. Run a service on the host machine at port 8083
2. Start the server `docker-compose up server -d`
3. Then the client `docker-compose up client -d`
4. Go to `http://localhost:9083`. You should see the service from port 8083.

You can view the admin dashboard at `http://localhost:7500`
