# Build images

        docker build -t kuska-bpm ./kuska-bpm
        docker image tag kuska-bpm:latest  hhuaranga/kuska-bpm:1.0.0
        docker image push hhuaranga/kuska-bpm:1.0.0
		
		docker build -t kuska-bpm-apiext ./kuska-bpm-apiext
        docker image tag kuska-bpm-apiext:latest  hhuaranga/kuska-bpm-apiext:1.0.0
        docker image push hhuaranga/kuska-bpm-apiext:1.0.0

        docker build -t kuska-sim ./kuska-sim
        docker image tag kuska-sim:latest  hhuaranga/kuska-sim:1.0.0
        docker image push hhuaranga/kuska-sim:1.0.0
		
        docker build -t tomcat ./tomcat_9_0_91_alpine_java11
        docker image tag tomcat:latest  hhuaranga/tomcat:9.0.91-Alpine-java11
        docker image push hhuaranga/tomcat:9.0.91-Alpine-java11