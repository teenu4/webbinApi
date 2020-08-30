web: if [ "$RAILS_ENV" = "production" ]; then bundle exec puma -C ./config/puma.rb -q; else   bundle exec puma -p 3001 -e development; fi
log: if [ "$RAILS_ENV" = "production" ]; then touch log/production.log; tail -f log/production.log; else touch log/development.log; tail -f log/development.log; fi
redis:	redis-server
sidekiq: bundle exec sidekiq -c 1
# ui: cd ../starScanFront/ && ember serve -p 4200