# Kongisrufen

## Requirements

Docker and Docker Compose

## Installation

```
$ docker-compose build
$ docker-compose up -d
```

### Trouble Shooting
Run docker-compose up without the -d flag to see build steps:

```
$docker-compose up
```

## Running for development

**Backend**

```
$ docker-compose exec backend mix phx.server
```

Visit [http://localhost:4000](http://localhost:4000)

**Frontend**

```
$ docker-compose exec frontend npm run dev
```

Visit [http://localhost:3000](http://localhost:3000)
