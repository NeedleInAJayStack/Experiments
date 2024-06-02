
To test, run the following and then start this server:

```bash
docker run -p 6379:6379 redis
```

In a separate terminal, run:

```bash
websocat ws://localhost:8080/ws
```

Finally, open a browser and go to `http://localhost:8080`. You should see a `Hi Redis!` message
each time you load the page.
