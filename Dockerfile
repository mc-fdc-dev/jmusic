FROM debian AS installer

WORKDIR /src

RUN apt-get update && apt-get install -y curl jq
RUN export VERSION=$(curl https://api.github.com/repos/jagrosh/MusicBot/releases | jq .[0].tag_name)
RUN echo "Version: $(VERSION)"
RUN curl -L -o JMusicBot.jar https://github.com/jagrosh/MusicBot/releases/download/$(VERSION)/JMusicBot-$(VERSION).jar

FROM debian

WORKDIR /app

RUN apt-get update && apt-get install -y default-jre
COPY --from=installer /src/JMusicBot.jar .

CMD ["java", "-Dnogui=true", "-jar", "JMusicBot.jar"]
