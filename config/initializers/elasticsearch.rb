Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: ENV.fetch('ELASTICSEARCH_URL', 'http://localhost:9200'), # default to localhost if ENV is not set
  transport_options: { request: { timeout: 5 } }
)