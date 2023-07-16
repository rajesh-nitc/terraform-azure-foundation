# aca-app

Run locally with docker

```docker network create mynetwork```

webspa:

```docker run -p 3000:3000 --network mynetwork --name webspa webspa```

api:

```docker run --network mynetwork --name api api```