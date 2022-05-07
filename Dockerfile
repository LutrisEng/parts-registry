FROM ghcr.io/lutriseng/docker-images/ruby:sha-64a27242a1a78aee73076384f295b0b650e13fe9

RUN apt-get install -y --no-install-recommends \
      libvips42 \
      libpoppler102 \
      imagemagick \
      ffmpeg \
      tmux \
    && apt-get clean

WORKDIR /app
ENV RAILS_ENV=production
COPY Gemfile* ./
RUN bundle install
COPY . ./
ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV
RUN mv config/credentials.yml.enc config/credentials.yml.enc.real && \
    mv config/credentials.yml.enc.fake config/credentials.yml.enc && \
    mv config/master.key.fake config/master.key && \
    bin/rails assets:precompile && \
    rm config/master.key && \
    mv config/credentials.yml.enc.real config/credentials.yml.enc

EXPOSE 8080
CMD ./bin/foreman start

