open OMRRPC_aux;;

module type MapperInterface =
	sig
		val process_key : key -> map_result
		val generate_key : unit -> key
	end;;