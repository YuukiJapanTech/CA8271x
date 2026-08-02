
##DP value (CoS 6)
ca_queue_wred_profile_set_marked_dp $profile 63 0
ca_queue_wred_profile_set_marked_dp $profile 63 1
ca_queue_wred_profile_set_marked_dp $profile 58 2
ca_queue_wred_profile_set_marked_dp $profile 53 3
ca_queue_wred_profile_set_marked_dp $profile 47 4
ca_queue_wred_profile_set_marked_dp $profile 42 5
ca_queue_wred_profile_set_marked_dp $profile 37 6
ca_queue_wred_profile_set_marked_dp $profile 32 7
ca_queue_wred_profile_set_marked_dp $profile 26 8
ca_queue_wred_profile_set_marked_dp $profile 21 9
ca_queue_wred_profile_set_marked_dp $profile 16 10
ca_queue_wred_profile_set_marked_dp $profile 11 11
ca_queue_wred_profile_set_marked_dp $profile 5 12
ca_queue_wred_profile_set_marked_dp $profile 0  13
ca_queue_wred_profile_set_marked_dp $profile 0  14
ca_queue_wred_profile_set_marked_dp $profile 0  15

ca_queue_wred_profile_set_unmarked_dp $profile 63 0
ca_queue_wred_profile_set_unmarked_dp $profile 63 1
ca_queue_wred_profile_set_unmarked_dp $profile 58 2
ca_queue_wred_profile_set_unmarked_dp $profile 53 3
ca_queue_wred_profile_set_unmarked_dp $profile 47 4
ca_queue_wred_profile_set_unmarked_dp $profile 42 5
ca_queue_wred_profile_set_unmarked_dp $profile 37 6
ca_queue_wred_profile_set_unmarked_dp $profile 32 7
ca_queue_wred_profile_set_unmarked_dp $profile 26 8
ca_queue_wred_profile_set_unmarked_dp $profile 21 9
ca_queue_wred_profile_set_unmarked_dp $profile 16 10
ca_queue_wred_profile_set_unmarked_dp $profile 11 11
ca_queue_wred_profile_set_unmarked_dp $profile 5  12
ca_queue_wred_profile_set_unmarked_dp $profile 0  13
ca_queue_wred_profile_set_unmarked_dp $profile 0  14
ca_queue_wred_profile_set_unmarked_dp $profile 0  15

ca_queue_wred_set 0 $port_id 7 $profile
