# Create roles
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by(name: role)
end

# Create admin user
admin_user = User.find_or_create_by(
  username: 'admin',
  email:    ENV['ADMIN_EMAIL'].dup
)
admin_user.name = ENV['ADMIN_NAME'].dup
admin_user.password = ENV['ADMIN_PASSWORD'].dup
admin_user.confirmed_at = Time.now
admin_user.save
admin_user.add_role :admin

# Create regular user
user = User.find_or_create_by(
  username: 'test_user',
  email:    ENV['USER_EMAIL'].dup
)
user.name = ENV['USER_NAME'].dup
user.password = ENV['USER_PASSWORD'].dup
user.confirmed_at = Time.now
user.save
user.add_role :user

# Import HTTP status codes
HttpStatusCode.create!([
  {value: 100, description: "Continue", reference: "[RFC2616]"},
  {value: 101, description: "Switching Protocols", reference: "[RFC2616]"},
  {value: 102, description: "Processing", reference: "[RFC2518]"},
  {value: 200, description: "OK", reference: "[RFC2616]"},
  {value: 201, description: "Created", reference: "[RFC2616]"},
  {value: 202, description: "Accepted", reference: "[RFC2616]"},
  {value: 203, description: "Non-Authoritative Information", reference: "[RFC2616]"},
  {value: 204, description: "No Content", reference: "[RFC2616]"},
  {value: 205, description: "Reset Content", reference: "[RFC2616]"},
  {value: 206, description: "Partial Content", reference: "[RFC2616]"},
  {value: 207, description: "Multi-Status", reference: "[RFC4918]"},
  {value: 208, description: "Already Reported", reference: "[RFC5842]"},
  {value: 226, description: "IM Used", reference: "[RFC3229]"},
  {value: 300, description: "Multiple Choices", reference: "[RFC2616]"},
  {value: 301, description: "Moved Permanently", reference: "[RFC2616]"},
  {value: 302, description: "Found", reference: "[RFC2616]"},
  {value: 303, description: "See Other", reference: "[RFC2616]"},
  {value: 304, description: "Not Modified", reference: "[RFC2616]"},
  {value: 305, description: "Use Proxy", reference: "[RFC2616]"},
  {value: 306, description: "Reserved", reference: "[RFC2616]"},
  {value: 307, description: "Temporary Redirect", reference: "[RFC2616]"},
  {value: 308, description: "Permanent Redirect", reference: "[RFC-reschke-http-status-308-07]"},
  {value: 400, description: "Bad Request", reference: "[RFC2616]"},
  {value: 401, description: "Unauthorized", reference: "[RFC2616]"},
  {value: 402, description: "Payment Required", reference: "[RFC2616]"},
  {value: 403, description: "Forbidden", reference: "[RFC2616]"},
  {value: 404, description: "Not Found", reference: "[RFC2616]"},
  {value: 405, description: "Method Not Allowed", reference: "[RFC2616]"},
  {value: 406, description: "Not Acceptable", reference: "[RFC2616]"},
  {value: 407, description: "Proxy Authentication Required", reference: "[RFC2616]"},
  {value: 408, description: "Request Timeout", reference: "[RFC2616]"},
  {value: 409, description: "Conflict", reference: "[RFC2616]"},
  {value: 410, description: "Gone", reference: "[RFC2616]"},
  {value: 411, description: "Length Required", reference: "[RFC2616]"},
  {value: 412, description: "Precondition Failed", reference: "[RFC2616]"},
  {value: 413, description: "Request Entity Too Large", reference: "[RFC2616]"},
  {value: 414, description: "Request-URI Too Long", reference: "[RFC2616]"},
  {value: 415, description: "Unsupported Media Type", reference: "[RFC2616]"},
  {value: 416, description: "Requested Range Not Satisfiable", reference: "[RFC2616]"},
  {value: 417, description: "Expectation Failed", reference: "[RFC2616]"},
  {value: 422, description: "Unprocessable Entity", reference: "[RFC4918]"},
  {value: 423, description: "Locked", reference: "[RFC4918]"},
  {value: 424, description: "Failed Dependency", reference: "[RFC4918]"},
  {value: 426, description: "Upgrade Required", reference: "[RFC2817]"},
  {value: 428, description: "Precondition Required", reference: "[RFC6585]"},
  {value: 429, description: "Too Many Requests", reference: "[RFC6585]"},
  {value: 431, description: "Request Header Fields Too Large", reference: "[RFC6585]"},
  {value: 500, description: "Internal Server Error", reference: "[RFC2616]"},
  {value: 501, description: "Not Implemented", reference: "[RFC2616]"},
  {value: 502, description: "Bad Gateway", reference: "[RFC2616]"},
  {value: 503, description: "Service Unavailable", reference: "[RFC2616]"},
  {value: 504, description: "Gateway Timeout", reference: "[RFC2616]"},
  {value: 505, description: "HTTP Version Not Supported", reference: "[RFC2616]"},
  {value: 506, description: "Variant Also Negotiates (Experimental)", reference: "[RFC2295]"},
  {value: 507, description: "Insufficient Storage", reference: "[RFC4918]"},
  {value: 508, description: "Loop Detected", reference: "[RFC5842]"},
  {value: 510, description: "Not Extended", reference: "[RFC2774]"},
  {value: 511, description: "Network Authentication Required", reference: "[RFC6585]"}
])
