# require 'httparty'
require 'json'

def lambda_handler(event:, context:)
  # Sample pure Lambda function

  # Parameters
  # ----------
  # event: Hash, required
  #     API Gateway Lambda Proxy Input Format
  #     Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

  # context: object, required
  #     Lambda Context runtime methods and attributes
  #     Context doc: https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html

  # Returns
  # ------
  # API Gateway Lambda Proxy Output Format: dict
  #     'statusCode' and 'body' are required
  #     # api-gateway-simple-proxy-for-lambda-output-format
  #     Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html

  # begin
  #   response = HTTParty.get('http://checkip.amazonaws.com/')
  # rescue HTTParty::Error => error
  #   puts error.inspect
  #   raise error
  # end
  #source_path = null
  # puts event
  # event['requestContext']['path'].split('/').each do | n | 
  #   puts n
  # end
  source_path = ''
  event['requestContext']['resourcePath'].split('/').each do |n|
    # {id} などのパスパラメータは組み込まず、以降のuriも検索対象には含めない
    break if /{.*}/ === n

    source_path << "/#{n}"
  end

  raise 'uri not found' if source_path.empty?

  puts source_path

  require ".#{source_path}/app"
  App.new(event, context).execute

end
