
##DP value (CoS 2)
ca_queue_wred_profile_set_marked_dp $profile 63 0
ca_queue_wred_profile_set_marked_dp $profile 63 1
ca_queue_wred_profile_set_marked_dp $profile 63 2
ca_queue_wred_profile_set_marked_dp $profile 63 3
ca_queue_wred_profile_set_marked_dp $profile 58 4
ca_queue_wred_profile_set_marked_dp $profile 53 5
ca_queue_wred_profile_set_marked_dp $profile 47 6
ca_queue_wred_profile_set_marked_dp $profile 42 7
ca_queue_wred_profile_set_marked_dp $profile 37 8
ca_queue_wred_profile_set_marked_dp $profile 32 9
ca_queue_wred_profile_set_marked_dp $profile 26 10
ca_queue_wred_profile_set_marked_dp $profile 21 11
ca_queue_wred_profile_set_marked_dp $profile 16 12
ca_queue_wred_profile_set_marked_dp $profile 11 13
ca_queue_wred_profile_set_marked_dp $profile 5  14
ca_queue_wred_profile_set_marked_dp $profile 0  15

ca_queue_wred_profile_set_unmarked_dp $profile 63 0
ca_queue_wred_profile_set_unmarked_dp $profile 63 1
ca_queue_wred_profile_set_unmarked_dp $profile 63 2
ca_queue_wred_profile_set_unmarked_dp $profile 58 3
ca_queue_wred_profile_set_unmarked_dp $profile 53 4
ca_queue_wred_profile_set_unmarked_dp $profile 47 5
ca_queue_wred_profile_set_unmarked_dp $profile 42 6
ca_queue_wred_profile_set_unmarked_dp $profile 37 7
ca_queue_wred_profile_set_unmarked_dp $profile 32 8
ca_queue_wred_profile_set_unmarked_dp $profile 26 9
ca_queue_wred_profile_set_unmarked_dp $profile 21 10
ca_queue_wred_profile_set_unmarked_dp $profile 16 11
ca_queue_wred_profile_set_unmarked_dp $profile 11  12
ca_queue_wred_profile_set_unmarked_dp $profile 5  13
ca_queue_wred_profile_set_unmarked_dp $profile 0  14
ca_queue_wred_profile_set_unmarked_dp $profile 0  15

ca_queue_wred_set 0 $port_id 2 $profile
