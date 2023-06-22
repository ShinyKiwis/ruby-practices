FROM ruby:3.0

WORKDIR /app 

COPY . /app 

RUN gem install bundler && bundle install

CMD ["ruby", "main.rb"]