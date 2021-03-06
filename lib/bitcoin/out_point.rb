module Bitcoin

  # outpoint class
  class OutPoint

    COINBASE_HASH = '0000000000000000000000000000000000000000000000000000000000000000'
    COINBASE_INDEX = 4294967295

    attr_reader :hash
    attr_reader :index

    def initialize(hash, index = -1)
      @hash = hash
      @index = index
    end

    def self.from_txid(txid, index)
      self.new(txid.rhex, index)
    end

    def coinbase?
      hash == COINBASE_HASH && index == COINBASE_INDEX
    end

    def to_payload
      [hash.htb, index].pack('a32V')
    end

    def self.create_coinbase_outpoint
      new(COINBASE_HASH, COINBASE_INDEX)
    end

    def valid?
      index >= 0 && (!coinbase? && hash != COINBASE_HASH)
    end

    # convert hash to txid
    def txid
      hash.rhex
    end

  end

end
