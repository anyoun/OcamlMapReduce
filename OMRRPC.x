typedef struct {
	int int_to_test;
} key;
typedef struct {
	key key;
	bool is_prime;
} map_result;

program OcamlMapReduce {
  version v1 {
    key get_next_key(void) = 1;
    void submit_results(map_result) = 2;
  } = 3;
} = 4;