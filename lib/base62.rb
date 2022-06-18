# Base62.encode(num)
# Base62.decode(encoded)
module Base62

  # Encodes base10 (decimal) number to base62 string.
  def self.encode(num, keys: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', keys_len: nil)
    str = ''
    return str if num.to_i == 0

    keys_len ||= keys.length
    while num > 0
      # prepend base62 charaters
      str = keys[num % keys_len] + str
      num = num / keys_len
    end
    str
  end

  # Decodes base62 string to a base10 (decimal) number.
  def self.decode(encoded, keys: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', keys_len: nil, keys_hash: nil)
    keys_len ||= keys.length
    keys_hash ||= keys.each_char.with_index.inject({}) { |h, (k, v)| h[k] = v; h }

    num = 0
    i = 0
    len = encoded.length
    # while loop is faster than each_char or other 'idiomatic' way
    while i < len
      pow = keys_len**(len - i - 1)
      num += keys_hash[encoded[i]] * pow
      i += 1
    end

    num
  end
end
