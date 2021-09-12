
# frozen_string_literal: true

require 'aws-sdk-s3'

Aws.config.update({region: 'ap-northeast-1'})

class MicroService::S3Bucket
  class << self
    def object(key)
      bucket.object(key)
    end

    def bucket
      Aws::S3::Resource.new.bucket(
        ENV['MICROSERVICE_S3_BUCKET_NAME']
      )
    end
  end
end
