(module
    (;Import variables from Js code;)
    (import "env" "print_string" (func $print_string(param i32)))
    (import "env" "buffer" (memory 1))

    (;Set a global var with the imported param;)
    (global $start_string (import "env" "start_string") i32)
    (global $string_len i32 (i32.const 12))
    
    (;Pass the location in memory where the module
      will write data;)
    (data (global.get $start_string) "hello world!")
    
    (;We define and export our function as helloworld;)
    (func (export "helloworld")
        (;call the imported print function, passing the len of str;)
        (call $print_string (global.get $string_len))
    )
)