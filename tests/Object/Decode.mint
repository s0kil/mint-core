suite "Object.Decode.field" {
  test "it returns an error if the input is null" {
    (Object.Decode.field("a", Object.Decode.string, `null`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAnObject
  }

  test "it returns an error if the input is undefined" {
    (Object.Decode.field("a", Object.Decode.string, `undefined`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAnObject
  }

  test "it returns an error if the input is an array" {
    (Object.Decode.field("a", Object.Decode.string, `[]`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAnObject
  }

  test "it returns an error if the input does not have the key" {
    (Object.Decode.field("a", Object.Decode.string, `{}`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::MissingObjectKey
  }

  test "it returns an error if the it could not decode the value" {
    (Object.Decode.field("a", Object.Decode.string, `{a: 0}`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAString
  }
}

suite "Object.Decode.string" {
  test "it returns an error if it's not a string" {
    (Object.Decode.string(`0`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAString
  }

  test "it returns the value" {
    (Object.Decode.string(`"asd"`)
    |> Result.withDefault("")) == "asd"
  }
}

suite "Object.Decode.time" {
  test "it returns an error if it's not a valid date" {
    (Object.Decode.time(`"asd"`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAValidTime
  }

  test "it returns the value" {
    (Object.Decode.time(`"2018-01-01"`)
    |> Result.withDefault(Time.now())) == Time.from(2018, 1, 1)
  }
}

suite "Object.Decode.number" {
  test "it returns an error if it's not a valid number" {
    (Object.Decode.number(`"asd"`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotANumber
  }

  test "it returns the value" {
    (Object.Decode.number(`300`)
    |> Result.withDefault(0)) == 300
  }
}

suite "Object.Decode.boolean" {
  test "it returns an error if it's not a valid boolean" {
    (Object.Decode.boolean(`"asd"`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotABoolean
  }

  test "it returns the value" {
    Object.Decode.boolean(`true`)
    |> Result.withDefault(false)
  }
}

suite "Object.Decode.array" {
  test "it returns an error if it's not a valid array" {
    (Object.Decode.array(Object.Decode.string, `"asd"`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAnArray
  }

  test "it propagates the error if there is any" {
    (Object.Decode.array(Object.Decode.string, `[0]`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAString
  }

  test "it returns the value" {
    (Object.Decode.array(Object.Decode.string, `["asd"]`)
    |> Result.withDefault([])) == ["asd"]
  }
}

suite "Object.Decode.maybe" {
  test "it returns an error if it's not a valid string" {
    (Object.Decode.maybe(Object.Decode.string, `0`)
    |> Result.withError(Object.Error::Unkown)) == Object.Error::NotAString
  }

  test "it returns nothing for null" {
    (Object.Decode.maybe(Object.Decode.string, `null`)
    |> Result.withDefault(Maybe.just("A"))) == Maybe.nothing()
  }

  test "it returns nothing for undefined" {
    (Object.Decode.maybe(Object.Decode.string, `undefined`)
    |> Result.withDefault(Maybe.just("A"))) == Maybe.nothing()
  }

  test "it returns value if ok" {
    (Object.Decode.maybe(Object.Decode.string, `"A"`)
    |> Result.withDefault(Maybe.nothing())) == Maybe.just("A")
  }
}
