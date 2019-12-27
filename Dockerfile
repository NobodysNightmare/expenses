FROM ruby:2.5

WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["rackup", "--host", "0.0.0.0", "-p", "3000"]
ENV RAILS_LOG_TO_STDOUT=true RAILS_SERVE_STATIC_FILES=true

ADD Gemfile Gemfile.lock ./
RUN bundle install --jobs 5 --frozen

COPY . ./
RUN rake assets:precompile
