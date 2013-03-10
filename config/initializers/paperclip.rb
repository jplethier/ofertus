# read configuration from config/AWS_CONFIG.yml
# configure paperclip for s3 storage
Paperclip::Attachment.default_options.merge!(
  :storage => 'fog',
  :fog_credentials => { "aws_access_key_id" => AWS_CONFIG['access_key_id'], "aws_secret_access_key" => AWS_CONFIG['secret_access_key'], "provider" => 'AWS', "region" => AWS_CONFIG['region'] },
  :fog_host => "http://#{AWS_CONFIG['bucket']}.s3.amazonaws.com",
  :fog_public => true,
  :default_url => "/images/attachments/missing.jpg",
  :fog_directory => AWS_CONFIG['bucket']
)