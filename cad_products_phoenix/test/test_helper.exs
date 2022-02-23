ExUnit.configure(seed: 0)
ExUnit.start()
Mox.defmock(CadProductsPhoenix.HTTPClientMock, for: HTTPoison.Base)
