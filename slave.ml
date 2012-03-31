open OMRRPC_clnt;;
open MapperImpl;;

let c = Rpc_client.Inet ("localhost",6789) in
let client = OMRRPC_clnt.OcamlMapReduce.V1.create_client c Rpc.Tcp in
let rec process_keys () =
	let n = OMRRPC_clnt.OcamlMapReduce.V1.get_next_key client () in
	let result = MapperImpl.process_key n in
	OMRRPC_clnt.OcamlMapReduce.V1.submit_results client result;
	process_keys () in
process_keys ();
print_endline "Done.";
Rpc_client.shut_down client;;
