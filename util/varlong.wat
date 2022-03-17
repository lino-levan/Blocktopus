(module
  (memory (export "mem") 1)
  (func $read_var_long
    (export "readVarLong")
    (param $ptr i32)
    (result i64 i32)
    (local $v i64)
    (local $length i64)
    (local $temp i64)

    (block $B0
      (loop $L0
        ;; CurrentByte
        local.get $ptr
        i64.load8_u
        local.tee $temp
        i64.const 127
        i64.and

        ;; << 7 * length
        local.get $length
        i64.shl
        ;; value |= i64.shl
        local.get $v
        i64.or
        local.set $v

        ;; length++;
        local.get $length
        i64.const 7
        i64.add
        local.tee $length

        ;; CurrentByte
        local.get $temp
        i64.const 128
        i64.and
        i64.eqz
        br_if $B0

        local.get $ptr
        i32.const 1
        i32.add
        local.set $ptr

        i64.const 70
        i64.lt_u
        br_if $L0
      )
      unreachable
    )

    local.get $v
    local.get $length
    i64.const 7
    i64.div_u
    i32.wrap_i64
  )
)