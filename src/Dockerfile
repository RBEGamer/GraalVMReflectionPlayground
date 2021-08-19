FROM ghcr.io/graalvm/graalvm-ce:21.2.0


#ENV DEBIAN_FRONTEND=noninteractive
#RUN apt-get update && apt upgrade -y && apt install ant


WORKDIR /opt/graalvm
# INSTALL NATIVE-IMAGE BIN
RUN gu install native-image
# COPY FILES OVER
COPY . /opt/reflection-test

# BUILD JAR
#RUN cd /opt/reflection-test && ant comile jar


# BUILD NATIVE IMAGE
RUN mkdir -p /opt/reflection-testr/native_image
RUN $JAVA_HOME/bin/native-image --no-fallback -H:ReflectionConfigurationFiles=/opt/reflection-test/reflectconfig.json -jar /opt/reflection-test/reflection.jar /opt/reflection-test/native_image/reflection

RUN chmod +x /opt/reflection-test/native_image/reflection
RUN chmod +x /opt/reflection-test/reflection.jar

# FINALLY EXECUTE SIMPLE TIME BENCHMARK
CMD ["/opt/reflection-test/benchmark.sh"]

