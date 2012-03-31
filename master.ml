open OMRRPC_aux;;
open OMRRPC_srv;;
open MapperImpl;;
open Sys;;

let esys = Unixqueue.create_unix_event_system () in
let start_time = Sys.time () in
let last_time = ref (Sys.time ()) in
let get_next_key = MapperImpl.generate_key in
let submit_results result = 
    let now = Sys.time () in
    if result.is_prime && (now -. !last_time > 1.0) then (
        last_time := now;
        let nps = (float_of_int result.key.int_to_test) /. (now -. start_time) in
        print_int result.key.int_to_test; 
        print_string ": ";
        print_string (string_of_bool result.is_prime);
        print_string " at ";
        print_float nps;
        print_string " numbers per second";
        print_newline ();
        flush stdout;
        () )
    else ()
in
let _ = 
    OMRRPC_srv.OcamlMapReduce.V1.create_server
    ~proc_get_next_key: (get_next_key)
    ~proc_submit_results: (submit_results)
    (Rpc_server.Localhost 6789)            (* connector *)
    Rpc.Tcp                                (* protocol *)
    Rpc.Socket                             (* mode *)
    esys
in
Unixqueue.run esys