# bpm_orch_deployment

Generate images manually

	docker build -t kuska-bpm ./kuska-bpm
	docker image tag kuska-bpm:latest  hhuaranga/kuska-bpm:1.0.2
	docker image push hhuaranga/kuska-bpm:1.0.2

	docker build -t kuska-bpm-db ./kuska-bpm-db
	docker image tag kuska-bpm-db:latest  hhuaranga/kuska-bpm-db:1.0.0
	docker image push hhuaranga/kuska-bpm-db:1.0.0

	docker build -t kuska-bpm-apiext ./kuska-bpm-apiext
	docker image tag kuska-bpm-apiext:latest  hhuaranga/kuska-bpm-apiext:1.0.0
	docker image push hhuaranga/kuska-bpm-apiext:1.0.0

	docker build -t kuska-sim ./kuska-sim
	docker image tag kuska-sim:latest  hhuaranga/kuska-sim:1.0.0
	docker image push hhuaranga/kuska-sim:1.0.0