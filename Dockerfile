FROM debian:stable-slim AS installer

WORKDIR /src

RUN apt-get update && apt-get install -y curl jq
RUN JMUSIC_VERSION=$(curl https://api.github.com/repos/jagrosh/MusicBot/releases | jq -r .[0].tag_name) && \
  echo $JMUSIC_VERSION && \
  curl -L -o JMusicBot.jar https://github.com/jagrosh/MusicBot/releases/download/$JMUSIC_VERSION/JMusicBot-$JMUSIC_VERSION.jar

FROM debian:stable-slim

WORKDIR /app

RUN apt-get update && apt-get install -y default-jre
COPY --from=installer /src/JMusicBot.jar .

CMD ["java", "-Dnogui=true", "-jar", "JMusicBot.jar"]
