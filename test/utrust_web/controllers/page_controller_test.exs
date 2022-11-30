defmodule UtrustWeb.PageControllerTest do
  use UtrustWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ " Hi you are looking for"
  end
end
