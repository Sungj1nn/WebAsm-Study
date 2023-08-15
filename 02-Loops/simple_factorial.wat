(module
    (import "env" "log" (func $log (param i32 i32)))
    (func $loop_test (export "loop_test") (param $n i32)
        (result i32)
        (local $i i32)
        (local $factorial i32)
 
        (local.set $factorial (i32.const 1))
        (loop $continue (block $break ;; $continue loop and $break block
            local.get $i
            i32.const 1
            i32.add    
            local.set $i ;; value of $i factorial

            local.get $i
            local.get $factorial
            i32.mul
            local.set $factorial ;; $factorial = $i * $factorial

            ;; call $log passing parameters $i, $factorial
            (call $log (local.get $i) (local.get $factorial))
    
            local.get $i
            local.get $n
            i32.eq
            br_if $break;;if $i==$n break from loop

            br $continue ;; branch to top of loop
        ))
        local.get $factorial ;; return $factorial to calling JavaScript
    )
)
