# frozen_string_literal: true

namespace :elasticsearch do
  desc 'Create and index all records of the Message model'
  task reindex: :environment do
    puts 'Creating index for the Message model...'

    Message.__elasticsearch__.create_index!(force: true)

    Message.import

    puts 'Indexing complete!'
  end
end
