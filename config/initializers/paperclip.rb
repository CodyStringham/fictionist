Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'

S3 = AWS::S3.new.buckets[ 'fictionist-noise' ]
