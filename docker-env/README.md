# Build images
- docker build -t kuska-bpm .
- docker build -t kuska-bpm-db .
- docker build -t kuska-bpm-apirest .
- docker build -t kuska-sim .

- docker image tag kuska-bpm:latest  hhuaranga/kuska-bonita-bpm:1.0.3
- docker image push hhuaranga/kuska-bonita-bpm:1.0.3
- docker image tag kuska-bpm-db:latest  hhuaranga/kuska-bonita-bpm-db:1.0.0
- docker image push hhuaranga/kuska-bonita-bpm-db:1.0.0