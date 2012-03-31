open MapperInterface;;
open OMRRPC_aux;;

module MapperImpl : MapperInterface = struct
	let is_divisible n m =
		n mod m = 0

	let is_prime n = 
		let rec is_prime2 n m = match m with
			  1 -> true
			| _ -> not (is_divisible n m) && is_prime2 n (m-1) in
		is_prime2 n (n-1)

	let rec find_primes_up_to limit start =
		if start = limit then ()
		else (
			if (is_prime start) then (
				print_string (string_of_int start);
				print_endline " is prime";
				()
			) else (
				()
			);
			find_primes_up_to limit (start+1)
		)

	let next_number = ref 2
	let process_key key = { key = key; is_prime = is_prime key.int_to_test }
	let generate_key () =
		let num = !next_number in
		next_number := !next_number + 1;
		{ int_to_test = num  }
end
(*find_primes_up_to 100 2;;*)