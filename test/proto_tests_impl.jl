
function test_hello(name::String)
    num_greetings = length(GREETINGS)
    rand_greeting = int((num_greetings-1)*rand()) + 1
    string(GREETINGS[rand_greeting], " ", name)
end

function test_exception()
    ex = InvalidOperation()
    set_field(ex, :oper, "test_exception")
    throw(ex)
end

function test_oneway()
    println("server received oneway method call")
end

function ping()
    println("server received ping method call")
end

function test_enum(enum_val::Int32)
    if enum_val == TestEnum.ONE
        return TestEnum.TEN
    elseif enum_val == TestEnum.TWO
        return TestEnum.TWENTY
    end
    ex = InvalidOperation()
    set_field(ex, :oper, "test_enum")
    throw(ex)
end

function _test_types(types)
    set_field(types, :bool_val,     !get_field(types, :bool_val))
    set_field(types, :byte_val,     uint8(get_field(types, :byte_val) + 1))
    set_field(types, :i16_val,      int16(get_field(types, :i16_val) + 1))
    set_field(types, :i32_val,      int32(get_field(types, :i32_val) + 1))
    set_field(types, :i64_val,      int64(get_field(types, :i64_val) + 1))
    set_field(types, :double_val,   -(get_field(types, :double_val)))
    set_field(types, :string_val,   uppercase(get_field(types, :string_val)))

    d = Dict{Int32,Int16}()
    for (k,v) in get_field(types, :map_val)
        d[k] = int16(2*v)
    end
    set_field(types, :map_val, d)

    l = Int16[]
    for v in get_field(types, :list_val)
        push!(l, int16(v+10))
    end
    set_field(types, :list_val, l)

    s = Set{Uint8}()
    for v in get_field(types, :set_val)
        push!(s, uint8(v+10))
    end
    set_field(types, :set_val, s)
    types
end

test_types(types::AllTypes) = _test_types(types)
test_types_default(types::AllTypesDefault) = _test_types(types)

