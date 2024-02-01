FROM debian AS installer

WORKDIR /src

RUN apt-get update && apt-get install wget
RUN wget https://github.com/jagrosh/MusicBot/releases/download/0.3.9/JMusicBot-0.3.9.jar
