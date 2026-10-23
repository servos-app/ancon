module Ancon
  # The plain v1 endpoints. Resources whose endpoint moved to a later version
  # define the method themselves instead.
  module Listable
    def list(**params)
      client.get(path, params: Query.list(**params))
    end
  end

  module Retrievable
    def retrieve(id)
      client.get(path(id))
    end
  end

  module Creatable
    def create(body)
      client.post(path, body: body)
    end
  end

  module Updatable
    def update(id, body)
      client.put(path(id), body: body)
    end
  end

  module Deletable
    def delete(id)
      client.delete(path(id))
    end
  end
end
