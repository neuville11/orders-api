FROM ruby:2.7.1 AS rails-toolbox

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

RUN gem install rails bundler
WORKDIR $INSTALL_PATH

CMD ["/bin/sh"]
